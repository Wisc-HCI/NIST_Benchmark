#!/usr/bin/env python

import sys
import rospy as ros

from actionlib import SimpleActionClient
from sensor_msgs.msg import JointState
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
from control_msgs.msg import FollowJointTrajectoryAction, \
                             FollowJointTrajectoryGoal, FollowJointTrajectoryResult
from franka_gripper.msg import MoveAction, MoveGoal, MoveResult

NODE_NAME = 'any_joint_pose'

class any_joint_pose_node:
    def __init__(self):

        # In launchfile these are remapped to namespace 
        # effort_joint_trajectory_controller/ and franka_state_controller/
        self.action: str = ros.resolve_name('~follow_joint_trajectory')
        self.topic = ros.resolve_name('~joint_states')
        self.ik_service = ros.resolve_name('~')

        # action client and pseudo action server
        self.client = SimpleActionClient(self.action, FollowJointTrajectoryAction)
        ros.loginfo(f"{NODE_NAME}: Waiting for {self.action} action to come up")
        self.client.wait_for_server()
        
        # read current joint state for once
        # TODO: create a subscriber for joint states
        ros.loginfo(f"{NODE_NAME}: Waiting for message on topic {self.topic}")
        joint_state = ros.wait_for_message(self.topic, JointState)
        self.initial_pose = dict(zip(joint_state.name, joint_state.position))
        self.current_pose = self.initial_pose   # TODO: deep copy


        # read joint pose and gripper width from ROS parameter
        param: str = ros.resolve_name('~load_gripper')
        self.load_gripper: bool = ros.get_param(param, False)
        if self.load_gripper:
            # create a client for the gripper action
            self.gripper_move: str = ros.resolve_name('~move/goal')
            self.gripper_client = SimpleActionClient(self.gripper_move, MoveAction)
            self.gripper_client.wait_for_server()

        # TODO: use IK service to get joint pose

        # update self.joint_pose and self.gripper_config
        # self.readOnce()     

    def readOnce(self, private_param: str = 'joint_pose'):
        """
        Read joint pose and gripper pose from ROS parameter for once
        """
        param: str = ros.resolve_name('~' + private_param)
        joint_pose = ros.get_param(param, None)    # target joint pose
        if joint_pose is None:
            ros.logerr(f'{NODE_NAME}: Could not find required parameter {param}')
            sys.exit(1)
        return joint_pose
        # if self.load_gripper:
        #     param: str = ros.resolve_name('~gripper_config')
        #     self.gripper_config = ros.get_param(param, None)    # target gripper width
        #     if self.gripper_config is None:
        #         ros.logerr(f'{NODE_NAME}: Could not find required parameter {param}')
        #         sys.exit(1)


    def move_to_pose(self, joint_pose):
        max_movement = max(abs(joint_pose[joint] - self.current_pose[joint]) for joint in joint_pose)
        point = JointTrajectoryPoint()
        point.time_from_start = ros.Duration.from_sec(
            # Use either the time to move the furthest joint with 'max_dq' or 500ms,
            # whatever is greater
            max(max_movement / ros.get_param('~max_dq', 0.5), 0.5)
        )
        goal = FollowJointTrajectoryGoal()
        goal.trajectory.joint_names, point.positions = [list(x) for x in zip(*joint_pose.items())]    # joint names and target joint pose
        
        point.velocities = [0] * len(joint_pose)   # stop at target pose (velocity = 0)
        goal.trajectory.points.append(point)    # only one point in trajectory
        goal.goal_time_tolerance = ros.Duration.from_sec(0.5)

        ros.loginfo(f'{NODE_NAME}: Sending trajectory Goal to move into specified config')
        self.client.send_goal_and_wait(goal)
        result = self.client.get_result()
        self.check_result(result)
        

    def hardcoding_move_test(self):
        joint_pose1 = ros.get_param('~joint_pose1', None)    # target joint pose
        joint_pose2 = ros.get_param('~joint_pose2', None)    # target joint pose
        joint_pose3 = ros.get_param('~joint_pose2', None)    # target joint pose


        goal = FollowJointTrajectoryGoal()
        joint_traj = JointTrajectory()
        joint_traj.joint_names = list(joint_pose1.keys())

        point = JointTrajectoryPoint()
        duration = 0.5
        point.time_from_start = ros.Duration.from_sec(duration)
        point.positions = [joint_pose1[joint_name] for joint_name in joint_traj.joint_names]
        joint_traj.points.append(point)

        point = JointTrajectoryPoint()
        duration += duration
        point.time_from_start = ros.Duration.from_sec(duration)
        point.positions = [joint_pose2[joint_name] for joint_name in joint_traj.joint_names]
        joint_traj.points.append(point)

        point = JointTrajectoryPoint()
        duration += duration
        point.time_from_start = ros.Duration.from_sec(duration)
        point.positions = [joint_pose3[joint_name] for joint_name in joint_traj.joint_names]
        point.velocities = [0] * len(joint_pose3)
        joint_traj.points.append(point)

        goal.trajectory = joint_traj
        goal.goal_time_tolerance = ros.Duration.from_sec(0.5)

        self.client.send_goal_and_wait(goal)
        result = self.client.get_result()
        self.check_result(result)
        


    def move_gripper(self):
        if not self.load_gripper:
            ros.logerr(f'{NODE_NAME}: Gripper is not loaded. Cannot move gripper.')
            sys.exit(1)
        
        goal = MoveGoal()
        goal.width = self.gripper_config.width
        goal.speed = self.gripper_config.speed

        ros.loginfo(f'{NODE_NAME}: Sending gripper Goal to move into specified config')
        self.gripper_client.send_goal_and_wait(goal)
        result = self.gripper_client.get_result()
        self.check_gripper_result(result)



    def check_result(self, result: FollowJointTrajectoryResult):
        if result.error_code != FollowJointTrajectoryResult.SUCCESSFUL:
            ros.logerr(f'{NODE_NAME}: Movement was not successful: ' + {
                FollowJointTrajectoryResult.INVALID_GOAL:
                """
                The joint pose you want to move to is invalid (e.g. unreachable, singularity...).
                Is the 'joint_pose' reachable?
                """,

                FollowJointTrajectoryResult.INVALID_JOINTS:
                """
                The joint pose you specified is for different joints than the joint trajectory controller
                is claiming. Does you 'joint_pose' include all 7 joints of the robot?
                """,

                FollowJointTrajectoryResult.PATH_TOLERANCE_VIOLATED:
                """
                During the motion the robot deviated from the planned path too much. Is something blocking
                the robot?
                """,

                FollowJointTrajectoryResult.GOAL_TOLERANCE_VIOLATED:
                """
                After the motion the robot deviated from the desired goal pose too much. Probably the robot
                didn't reach the joint_pose properly
                """,
            }[result.error_code])

        else:
            ros.loginfo(f'{NODE_NAME}: Successfully moved arm into specified pose')


    def check_gripper_result(self, result: MoveResult):
        if not result.success:
            ros.logerr(f'{NODE_NAME}: Gripper movement was not successful\n {result.error}')
        else:
            ros.loginfo(f'{NODE_NAME}: Successfully moved gripper into specified pose')




def main():
    ros.init_node(NODE_NAME)
    node = any_joint_pose_node()
    # node.readOnce()
    # node.move_to_pose()
    # if node.load_gripper:
        # node.move_gripper()
    node.hardcoding_move_test()
    # TODO: finally spin the node


if __name__ == '__main__':
    main()