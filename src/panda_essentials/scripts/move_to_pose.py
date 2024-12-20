#!/usr/bin/env python

import sys
import rospy as ros
import tf2_ros

from actionlib import SimpleActionClient
from sensor_msgs.msg import JointState
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
from control_msgs.msg import FollowJointTrajectoryAction, \
                             FollowJointTrajectoryGoal, FollowJointTrajectoryResult
from geometry_msgs.msg import TransformStamped, Pose
from franka_gripper.msg import GraspAction, GraspGoal, GraspResult
from franka_msgs.msg import FrankaState

from relaxed_ik_ros1.msg import EEPoseGoals, EEVelGoals
from relaxed_ik_ros1.srv import IKPoseRequest,  IKPose, IKPoseResponse

from planner import GlobalPlanner, LocalPlanner
from uitils import time_consumption, transformstamped_to_pose, \
    check_follow_joint_traj_result, dict_to_pose, dict_to_grasp
from robot import Robot


class Params:
    """
    Load ROS parameters
    """
    def __init__(self):
        # move node config
        rate = ros.get_param('~rate', None)
        node_name = ros.get_param('~node_name', "move_to_pose")
        target_pose = dict_to_pose(ros.get_param('~target_pose', None))
        target_grasp = dict_to_grasp(ros.get_param('~target_grasp', None))
        ik_config = ros.get_param('~inverse_kinematics', None)
        debugger = ros.get_param('~debugger', False)
        load_gripper = ros.get_param('~load_gripper', False)
        
        hardcoding = ros.get_param('~hardcoding', None)

        # planner config
        gp_config = ros.get_param('~global_planner', None)
        lp_config = ros.get_param('~local_planner', None)
        debugger = ros.get_param('~debugger', False)

        lp_size = lp_config['step_size'] * lp_config['steps']


class MoveToPose:
    def __init__(self, params: Params):

        # read parameters
        self.params = params
        self.rate = ros.Rate(self.params.rate)

        # connect to action server
        # remmapped in launch file
        remapped_joint_action_server: str = ros.resolve_name('~follow_joint_trajectory')
        remapped_joint_state_topic = ros.resolve_name('~joint_states')
        remapped_gripper_action_server = ros.resolve_name('~grasp')

        self.joint_action_client = SimpleActionClient(remapped_joint_action_server, FollowJointTrajectoryAction)
        ros.loginfo(f"{self.params.node_name}: Waiting for {remapped_joint_action_server} action to come up")
        self.joint_action_client.wait_for_server()
        
        # Subscribe to franka_state_controller
        self.franka_state_sub = ros.Subscriber("franka_state_controller/franka_states", FrankaState, self.franka_state_callback)
        self.franka_joint_state_sub = ros.Subscriber("franka_state_controller/joint_states", JointState, self.franka_joint_state_callback)
        
        # transformation listener
        self.tf_buffer = tf2_ros.Buffer()
        init_ee_pose= self.get_ee_pose()

        # read joint state
        joint_state = ros.wait_for_message(remapped_joint_state_topic, JointState)
        joint_state_dict = dict(zip(joint_state.name, joint_state.position))
        self.current_joint_state = joint_state

        # create robot object
        setting_file_path = ros.get_param('~setting_file_path', None)
        self.robot = Robot(setting_file_path)
        
        # forward kinematics
        init_fk_ee_pos = self.robot.fk(joint_state.position)
        
        ros.logdebug(f"Initial EE pose from /tf: {init_ee_pose} \nInitial EE pose from IK: {init_fk_ee_pos}")
        
        # connect to planners
        self.gp = GlobalPlanner(self.params)
        self.lp = LocalPlanner(self.params)

        # connect to inverse kinematics service
        ros.wait_for_service(self.params.ik_config['solver_service'])
        self.ik_pose_service = ros.ServiceProxy(self.params.ik_config['solver_service'], IKPose)
        self.ik_pose_pub = ros.Publisher(self.params.ik_config['solver_topic'], EEPoseGoals, 1)
        self.ik_reset_pub = ros.Publisher(self.params.ik_config['solver_reset'], JointState)

        # create a timer for updating the robot state
        self.timer = ros.Timer(ros.Duration(0.5), self.timer_callback)

        # read joint pose and gripper width from ROS parameter
        self.load_gripper = self.params.load_gripper
        if self.load_gripper:
            # create a client for the gripper action
            self.gripper_action_client = SimpleActionClient(remapped_gripper_action_server, GraspAction)
            ros.loginfo(f"{self.params.node_name}: Waiting for {remapped_gripper_action_server} action to come up")
            self.gripper_action_client.wait_for_server()
            

    
    def franka_state_callback(self, msg):
        self.current_franka_state = msg
        
    def franka_joint_state_callback(self, msg):
        joint_state = msg
        joint_state_dict = dict(zip(joint_state.name, joint_state.position))
        self.current_joint_state = joint_state

    
    def get_joint_state(self) -> JointState:
        return self.current_joint_state
        
    def get_ee_pose(self) -> TransformStamped:
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)
        # read tf tree
        try:
            ee_trans = self.tf_buffer.lookup_transform("world", "panda_hand", ros.Time())
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException) as e:
            ros.logerror(f"Failed to lookup transform: {e}")
            
        ee_pose = transformstamped_to_pose(ee_trans)
        return ee_pose

    def set_target(self, target_pose: Pose = None, target_grasp = None):
        if target_pose is None:
            self.target_pose= self.params.target_pose
        
        if self.load_gripper and target_grasp is None:
            self.target_grasp = self.params.target_grasp
    
        return
    
    def timer_callback(self):
        raise NotImplementedError("Timer callback is not implemented yet")
        # self.local_plan_to_action()
    
    def task_plan_to_local_plan(self):
        raise NotImplementedError("Task planning is not implemented yet")
        return
    
    @time_consumption(enabled=True)
    def local_plan_to_action(self):
        
        joint_state = self.get_joint_state()
        ee_pose = self.get_ee_pose()
        
        # task planner is not ready
        # self.task_plan_to_local_plan()
        
        # self.gp.set_target(self.target_pose)
        # local_target_pose = self.gp.plan(ee_pose)
        
        local_target_pose = self.target_pose        # hardcoding for test
        if local_target_pose == self.target_pose:
            stop_at_target = True
        else:
            stop_at_target = False
        
        # update local planner
        self.lp.set_target(local_target_pose)
        ee_pose_traj = self.lp.plan_interpolation(ee_pose)
        
        # trajectory action goal
        goal = FollowJointTrajectoryGoal()
        joint_traj = JointTrajectory()
        joint_traj.joint_names = joint_state.name
        duration = 0
        dt = 0.1
        
        # communicate with IK solver and specify action gaol
        self.ik_reset_pub.publish(ee_pose)
        for i in range(len(ee_pose_traj)):
            req = IKPoseRequest()
            req.ee_poses.append(ee_pose_traj[i])
            # TODO: req.tolerances
            ik_solution = self.ik_pose_service(req)
            
            point = JointTrajectoryPoint()
            duration += dt
            point.time_from_start = ros.Duration.from_sec(duration)
            point.positions = ik_solution.joint_state
            if i == len(ee_pose_traj)-1 and stop_at_target:
                point.velocities = [0] * len(joint_state.name)
                
            joint_traj.points.append(point)
        
        # move
        goal.trajectory = joint_traj
        goal.goal_time_tolerance = ros.Duration.from_sec(0.1)
        
        # wait for action result or not? wait at test, but not in real application
        self.joint_action_client.send_goal_and_wait(goal)
        result = self.joint_action_client.get_result()
        # check_follow_joint_traj_result(result, self.params.node_name)
        ros.loginfo(f"Result: {result}")
        
        # self.joint_action_client.send_goal(goal)
        
        return
    

    def move_gripper(self):
        if not self.load_gripper:
            ros.logerr(f'{self.params.node_name}: Gripper is not loaded. Cannot move gripper.')
            sys.exit(1)
        
        goal = GraspGoal()
        goal.width = self.target_grasp.width
        goal.speed = self.target_grasp.speed
        # goal.force = self.target_grasp.force
        # goal.epsilon = self.target_grasp.epsilon

        self.gripper_action_client.send_goal_and_wait(goal)
        result = self.gripper_action_client.get_result()
        ros.loginfo(f"Result: {result}")

        return


def main():
    print(ros.resolve_name('~name'))
    print("...................................................................................")
    ros.init_node("move_to_pose")
    params = Params()
    node = MoveToPose(params)
    print(ros.resolve_name('~name'))
    
    # test: just update once
    node.set_target()
    node.local_plan_to_action()
    
    ros.loginfo(f"{params.node_name}: Test finished")
    ros.singal_shutdown("Test finished")



if __name__ == '__main__':
    main()