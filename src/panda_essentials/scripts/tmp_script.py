#!/usr/bin/env python

import sys
import rospy as ros
import tf2_ros
import rospkg
import yaml

from actionlib import SimpleActionClient
from sensor_msgs.msg import JointState
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
from control_msgs.msg import FollowJointTrajectoryAction, \
                             FollowJointTrajectoryGoal, FollowJointTrajectoryResult
from geometry_msgs.msg import TransformStamped, Pose
from franka_gripper.msg import GraspAction, GraspGoal, GraspResult
from franka_msgs.msg import FrankaState

# from relaxed_ik_ros1.msg import EEPoseGoals, EEVelGoals
# from relaxed_ik_ros1.srv import IKPoseRequest,  IKPose, IKPoseResponse

# from planner import GlobalPlanner, LocalPlanner
# from uitils import time_consumption, transformstamped_to_pose, \
    # check_follow_joint_traj_result, dict_to_pose, dict_to_grasp
from robot import Robot


def fun1():
    path_to_src = rospkg.RosPack().get_path('relaxed_ik_ros1') + '/relaxed_ik_core'
    setting_file_path = "/root/workspace/src/panda_essentials/config/panda.yaml"
    setting_file = open(setting_file_path, 'r')
    settings = yaml.load(setting_file, Loader=yaml.FullLoader)
        
    # urdf_file = open(path_to_src + '/configs/urdfs/' + settings["urdf"], 'r')
    # urdf_string = urdf_file.read()
    # ros.set_param('robot_description', urdf_string)

    robot = Robot(setting_file_path)
    starting_ee_poses =  robot.fk(settings['starting_config'])

    print(starting_ee_poses)


if __name__ == "__main__":
    # ros.init_node("tmp_node")

    fun1()

    # ros.signal_shutdown("end test")
