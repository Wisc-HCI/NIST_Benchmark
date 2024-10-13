#!/usr/bin/env python3

import rospy

from panda_robot import PandaArm
from geometry_msgs.msg import Pose
from relaxed_ik_ros1.srv import IKPoseRequest, IKPose


def move_to_caresian_position(
    arm:PandaArm,
    x:float, y:float, z:float, 
    orientation_x:float, orientation_y:float, orientation_z:float, orientation_w:float):

    """
    Moves arm to so that the end-effector position is at (x, y, z) in meters with quaternion orientation
    (orientation_x, orientation_y,  orientation_z, orientation_w).
    """


    desired_pose = Pose()
    # Set your desired x, y, z positions
    desired_pose.position.x = x
    desired_pose.position.y = y
    desired_pose.position.z = z
    # Set your desired orientation
    desired_pose.orientation.x = orientation_x
    desired_pose.orientation.y = orientation_y
    desired_pose.orientation.z = orientation_z
    desired_pose.orientation.w = orientation_w

    req = IKPoseRequest()

    req.ee_poses.append(desired_pose)

    ik_pose_service = rospy.ServiceProxy('relaxed_ik/solve_pose', IKPose)

    ik_joint_solutions = ik_pose_service(req).joint_state
    print("Calculated Joint Configuration:", ik_joint_solutions)
    arm.move_to_joint_position(ik_joint_solutions) # [-8.48556818e-02, -8.88127666e-02, -6.59622769e-01, -1.57569726e+00, -4.82374882e-04,  2.15975946e+00,  4.36766917e-01]






if __name__ == '__main__':

    rospy.init_node("panda_demo") # initialise ros node
    arm = PandaArm() 
    arm.move_to_neutral()
    move_to_caresian_position(arm, 0.5, 0, 0.3, 1.0, 0.0, 0.0, 0.0)