#!/usr/bin/env python3

import rospy

from panda_robot import PandaArm
from geometry_msgs.msg import Pose
from relaxed_ik_ros1.srv import IKPoseRequest, IKPose
from transformations import quaternion_from_euler


def move_to_cartesian_position(
    arm:PandaArm,
    x:float, y:float, z:float, 
    roll:float, pitch:float, yaw:float):

    """
    Moves arm to so that the end-effector position is at (x, y, z) in meters with 
    and at orientation roll (rotation around x-axis), pitch (rotation around y-axis), and yaw 
    (rotation around z-axis) in radians.

    Return the array of IK joint positions calculated to move to positon [Joint_0, Joint_1, ..., Joint_6]
    """

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
    arm.move_to_joint_position(ik_joint_solutions) # [-8.48556818e-02, -8.88127666e-02, -6.59622769e-01, -1.57569726e+00, -4.82374882e-04,  2.15975946e+00,  4.36766917e-01]

    return ik_joint_solutions




if __name__ == '__main__':

    rospy.init_node("panda_demo") # initialise ros node
    arm = PandaArm() 
    arm.move_to_neutral()
    move_to_cartesian_position(arm, 
                              0.5, 0, 0.3, # X, Y, Z in m
                              0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    arm.exec_gripper_cmd(0.05) # Width between gripper in m
    arm.exec_gripper_cmd(0.03) # Width between gripper in m
    arm.move_to_neutral()