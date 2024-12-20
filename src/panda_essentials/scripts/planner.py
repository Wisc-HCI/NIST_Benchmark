#!/usr/bin/env python

import sys
import rospy as ros
import numpy as np
import math

from actionlib import SimpleActionClient
from sensor_msgs.msg import JointState
from geometry_msgs.msg import Pose, Point
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
from control_msgs.msg import FollowJointTrajectoryAction, \
                             FollowJointTrajectoryGoal, FollowJointTrajectoryResult

from relaxed_ik_ros1.msg import EEPoseGoals, EEVelGoals
from relaxed_ik_ros1.srv import IKPoseRequest, IKPose, IKPoseResponse

from transformations import quaternion_slerp
from uitils import time_consumption

# class Params:
#     """
#     Load ROS parameters for global planner, local planner, inverse kinematics, and debugger
#     """

#     gp_config = ros.get_param('~global_planner', None)
#     lp_config = ros.get_param('~local_planner', None)
#     ik_config = ros.get_param('~inverse_kinematics', None)
#     debugger = ros.get_param('~debugger', False)

#     lp_size = lp_config['step_size'] * lp_config['steps']


class GlobalPlanner:
    def __init__(self, params):
        # task planner
        self.gp_config = params.gp_config
        self.ik_config = params.ik_config
        self.lp_size = params.lp_size
        self.debugger = params.debugger

        # # Subscribe to IK service/topics
        # ros.wait_for_service(self.ik_config['service'])
        # self.ik_pose_service = ros.ServiceProxy(self.ik_config['service'], IKPose)

    def set_target(self, target):
        self.target_pose = target
        
    def set_task(self, task):
        raise NotImplementedError("Task planning is not implemented yet")
        self.task = task

    @time_consumption(enabled=True)
    def plan_interpolation(self, current_pose):
        """
        Global planner to plan the path from current state to target state
        return local_target_pose
        """
        distance = np.linalg.norm([self.target_pose.position.x - current_pose.position.x,
                                        self.target_pose.position.y - current_pose.position.y,
                                        self.target_pose.position.z - current_pose.position.z])
        local_target_pose = Pose()
        
        if distance <= self.lp_size:
            ros.loginfo("Approaching target in Euclidean space. Euclidean distance: {distance}")
            local_target_pose = self.target_pose

        else:
            ros.loginfo(f"Getting global linear samples. Euclidean distance: {distance}")
            local_target_pose.position.x = current_pose.position.x + self.localplanner_size * (self.target_pose.position.x - current_pose.position.x) / distance
            local_target_pose.position.y = current_pose.position.y + self.localplanner_size * (self.target_pose.position.y - current_pose.position.y) / distance
            local_target_pose.position.z = current_pose.position.z + self.localplanner_size * (self.target_pose.position.z - current_pose.position.z) / distance
            
        return local_target_pose
    
    def plan_task(self):
        raise NotImplementedError("Task planning is not implemented yet")
        self.task
        return


class LocalPlanner:
    def __init__(self, params):
        
        self.lp_config = params.lp_config
        self.ik_config = params.ik_config
        self.lp_size = params.lp_size   # we don't need this in this branch
        
    def set_target(self, target):
        self.target_pose = target
    
    @time_consumption(enabled=True)
    def plan_interpolation(self, current_pose):
        """
        Local planner to plan the path from current state to target state with SLERP Interpolation
         @ return ee_pose_traj
        """
        print(current_pose)
        distance = np.linalg.norm([self.target_pose.position.x - current_pose.position.x,
                                   self.target_pose.position.y - current_pose.position.y,
                                   self.target_pose.position.z - current_pose.position.z])
        
        distance_to_plan = distance.item()
        steps_to_plan = math.ceil(distance_to_plan / self.lp_config['step_size'])
        assert steps_to_plan <= 1000, "Steps to plan exceed the maximum steps"

        ee_pose_traj = list()
        for i in range(1, self.steps_to_plan):
            ee_pose = Pose()
            ee_pose.position.x = current_pose.position.x + i / self.steps_to_plan * (self.target_pose.position.x - current_pose.position.x)
            ee_pose.position.y = current_pose.position.y + i / self.steps_to_plan * (self.target_pose.position.y - current_pose.position.y)
            ee_pose.position.z = current_pose.position.z + i / self.steps_to_plan * (self.target_pose.position.z - current_pose.position.z)
            # quaternion_slerp uses [w, x, y, z] as quaternion, O(1) complexity
            q_f = quaternion_slerp(current_pose.orientation, self.target_pose.orientation, i / self.steps_to_plan)
            ee_pose.orientation.x = q_f[1]
            ee_pose.orientation.y = q_f[2]
            ee_pose.orientation.z = q_f[3]
            ee_pose.orientation.w = q_f[0]
            # No tolerance
            ee_pose_traj.append(ee_pose)
        
        ee_pose_traj.append(self.target_pose)   # Add the target state as the last waypoint
        assert len(ee_pose_traj) == steps_to_plan, f"Actual waypoints: {ee_pose_traj}, Expected steps: {steps_to_plan}"
        
        return ee_pose_traj

      
    # Add this to the ROS node
    def use_ik_service(self, ee_pose):
        """
        It is not recommended to use the ROS functionality in scripts outside the ROS node.
        """
        pass
        # req = IKPoseRequest()
        # req.ee_pose = ee_pose
        # res: IKPoseResponse = self.ik_pose_service(req)
        # ik_joint_solutions = res.joint_state
        # ik_joint_seq.append(ik_joint_solutions)
    
        # return ik_joint_seq