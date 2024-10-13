#! /usr/bin/env python3

import csv
import ctypes
import numpy as np
import os
import rospkg
import rospy
import sys
import transformations as T
import yaml

from timeit import default_timer as timer
from geometry_msgs.msg import Pose, Twist, Vector3
from relaxed_ik_ros1.msg import EEPoseGoals, EEVelGoals
from relaxed_ik_ros1.srv import IKPoseRequest,  IKPose
from robot import Robot


class TraceALine:
    def __init__(self):

        desired_pose = Pose()
        desired_pose.position.x = 0.1 # Set your desired x, y, z positions
        desired_pose.position.y = 0
        desired_pose.position.z = 0.3
        desired_pose.orientation.x = 1.0  # Set your desired orientation
        desired_pose.orientation.y = 0.0
        desired_pose.orientation.z = 0.0
        desired_pose.orientation.w = 0.0

        req = IKPoseRequest()

        req.ee_poses.append(desired_pose)

        self.ik_pose_service = rospy.ServiceProxy('relaxed_ik/solve_pose', IKPose)

        ik_solutions = self.ik_pose_service(req)
        print("Calculated Joint Configuration:", ik_solutions)



if __name__ == '__main__':
    rospy.init_node('LineTracing')
    trace_a_line = TraceALine()
    rospy.spin()
