#!/usr/bin/env python3
import rospy

from panda_robot import PandaArm
from move_to_position import move_to_cartesian_position



if __name__ == '__main__':

    rospy.init_node("panda_demo") # initialise ros node
    arm = PandaArm() 

    arm.exec_gripper_cmd(0.07)
    arm.move_to_neutral()
    
    # Move to bolt
    move_to_cartesian_position(arm, 
                              0.425, 0.0955, 0.2, # X, Y, Z in m
                              0, 0.0, 0.0) # Roll, Pitch, Yaw in rads

    # Grab bolt
    arm.exec_gripper_cmd(0.015) 

    # Move up
    move_to_cartesian_position(arm, 
                            0.425, 0.0955, 0.35, # X, Y, Z in m
                            0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    


    # Move across board
    move_to_cartesian_position(arm, 
                        0.29, -0.21, 0.35, # X, Y, Z in m
                        0, 0.0, 0.0) # Roll, Pitch, Yaw in rads

    # Move down board
    move_to_cartesian_position(arm, 
                        0.29, -0.21, 0.2, # X, Y, Z in m
                        0, 0.0, 0.0) # Roll, Pitch, Yaw in rads

    # Release bolt
    arm.exec_gripper_cmd(0.07)

    # Return to neutral position
    arm.move_to_neutral()