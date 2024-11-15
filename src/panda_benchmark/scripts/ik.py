#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Pose
from relaxed_ik_ros1.srv import IKPoseRequest, IKPose
from transformations import quaternion_from_euler


def get_cartesian_position(
    x:float, y:float, z:float, 
    roll:float, pitch:float, yaw:float):

    quat_x, quat_y, quat_z, quat_q = quaternion_from_euler(roll, pitch, yaw)

    desired_pose = Pose()
    # Set your desired x, y, z positions
    desired_pose.position.x = x
    desired_pose.position.y = y
    desired_pose.position.z = z
    # Set your desired orientation
    desired_pose.orientation.x = quat_x
    desired_pose.orientation.y = quat_y
    desired_pose.orientation.z = quat_z
    desired_pose.orientation.w = quat_q

    req = IKPoseRequest()

    req.ee_poses.append(desired_pose)

    ik_pose_service = rospy.ServiceProxy('relaxed_ik/solve_pose', IKPose)

    ik_joint_solutions = ik_pose_service(req).joint_state
    print("Calculated Joint Configuration:", ik_joint_solutions)
    return ik_joint_solutions