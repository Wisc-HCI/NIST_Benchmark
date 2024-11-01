#!/usr/bin/env python3
import rospy

from panda_robot import PandaArm
from move_to_position import move_to_cartesian_position

def move_to_cartesian_position_multiple_attempts(
    arm:PandaArm,
    x:float, y:float, z:float, 
    roll:float, pitch:float, yaw:float):
    """
    Recalculate IK a couple of times to get as close as possible so that the end-effector position is at (x, y, z) in meters with 
    and at orientation roll (rotation around x-axis), pitch (rotation around y-axis), and yaw 
    (rotation around z-axis) in radians.
    """

    # TODO: Find smatter way than just doing this a bunch of times
    ATTEMPTS = 8
    for _ in range(ATTEMPTS):
        move_to_cartesian_position(arm, 
                                    x, y, z, # X, Y, Z in m
                                    roll, pitch, yaw) # Roll, Pitch, Yaw in rads`

if __name__ == '__main__':

    rospy.init_node("panda_demo") # initialise ros node
    arm = PandaArm() 

    arm.exec_gripper_cmd(0.07)
    arm.move_to_neutral()
    
    # Move to bolt
    move_to_cartesian_position_multiple_attempts(arm, 
                              0.44, 0.0955, 0.2, # X, Y, Z in m
                              0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    
    # Grab bolt
    # TODO: Need smarter grip code that goes until times out or senses force or something (can't grip hard things)
    arm.exec_gripper_cmd(0.02) 

    # Move up
    move_to_cartesian_position_multiple_attempts(arm, 
                            0.44, 0.0955, 0.35, # X, Y, Z in m
                            0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    


    # Move across board
    move_to_cartesian_position_multiple_attempts(arm, 
                        0.3, -0.215, 0.35, # X, Y, Z in m
                        0, 0.0, 0.0) # Roll, Pitch, Yaw in rads

    # Move down board
    move_to_cartesian_position_multiple_attempts(arm, 
                        0.3, -0.215, 0.21, # X, Y, Z in m
                        0, 0.0, 0.0) # Roll, Pitch, Yaw in rads

    # Release bolt
    arm.exec_gripper_cmd(0.07)
    arm.exec_gripper_cmd(0.07)

    # Return to neutral position
    arm.move_to_neutral()