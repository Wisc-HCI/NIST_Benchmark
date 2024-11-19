#!/usr/bin/env python3

import rospy

from panda_robot import PandaArm
from geometry_msgs.msg import Pose
from relaxed_ik_ros1.srv import IKPoseRequest, IKPose
from transformations import quaternion_from_euler
import numpy as np




if __name__ == '__main__':
    rospy.init_node("panda_demo") # initialise ros node

    arm = PandaArm()
    arm.move_to_neutral()
    q = [0, -np.pi/4, 0, -2.5 * np.pi/4, 0, np.pi/2, np.pi/4]

    arm.move_to_joint_position(q)