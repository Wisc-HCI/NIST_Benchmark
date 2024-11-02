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
    ATTEMPTS = 3
    for _ in range(ATTEMPTS):
        move_to_cartesian_position(arm, 
                                    x, y, z, # X, Y, Z in m
                                    roll, pitch, yaw) # Roll, Pitch, Yaw in rads`
        
# TODO: linear interpolate role, pitch and yaw
def linear_interpolate(
    curr_x:float, curr_y:float, curr_z:float,  
    final_x:float, final_y:float, final_z:float,
    step_size:float = 0.01):
    """
    Returns array of (x,y,z) coordinate tuples in m that are evenly spaced 
    by step_size in m between the current and final x, y, and z values.
    The array of points forms a straight line.

    The calculation of the line equation (when t = 0 at current position 
    and t = 1 at final position) is"
        <x, y, z> = t * <final_x - curr_x, final_y - curr_y, final_z - curr_z> 
                    +  <curr_x, curr_y, curr_z>
    """
    
    t = 0
    final_t = 1

    distance = ((final_x - curr_x)**2 + (final_y - curr_y)**2 + (final_z - curr_z)**2) ** 0.5
    t_step = step_size / distance 
    
    trajectory = []

    while (t <= final_t):
        x = t * (final_x - curr_x) + curr_x
        y = t * (final_y - curr_y) + curr_y
        z = t * (final_z - curr_z) + curr_z
        trajectory += [(x, y, z)]
        t += t_step

    trajectory += [(final_x, final_y, final_z)]
        
    return trajectory


def move_to_cartesian_position_with_linear_trajectory(
    arm:PandaArm,
    x:float, y:float, z:float, 
    roll:float, pitch:float, yaw:float):
    """
    Given the desired position, makes a trajectory through linear interpolation
    and moves the robot to that point.
    """

    curr_x = arm.ee_pose()[0][0]
    curr_y = arm.ee_pose()[0][1]
    curr_z = arm.ee_pose()[0][2]
    trajectory = linear_interpolate(curr_x, curr_y, curr_z, x, y, z, 0.1)
    
    for position in trajectory:
        move_to_cartesian_position(arm, 
                                    position[0], position[1], position[2], # X, Y, Z in m
                                    roll, pitch, yaw) # Roll, Pitch, Yaw in rads`


if __name__ == '__main__':

    rospy.init_node("panda_demo") # initialise ros node
    arm = PandaArm() 

    arm.exec_gripper_cmd(0.07)
    arm.move_to_neutral()
    
    # Move to bolt
    move_to_cartesian_position_with_linear_trajectory(arm, 
                              0.425, 0.0955, 0.2, # X, Y, Z in m
                              0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    
    # Grab bolt
    arm.exec_gripper_cmd(0.015) 

    # Move up
    move_to_cartesian_position_with_linear_trajectory(arm, 
                            0.425, 0.0955, 0.35, # X, Y, Z in m
                            0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    


    # Move across board
    move_to_cartesian_position_with_linear_trajectory(arm, 
                        0.29, -0.21, 0.35, # X, Y, Z in m
                        0, 0.0, 0.0) # Roll, Pitch, Yaw in rads

    # Move down board
    move_to_cartesian_position_with_linear_trajectory(arm, 
                        0.29, -0.21, 0.2, # X, Y, Z in m
                        0, 0.0, 0.0) # Roll, Pitch, Yaw in rads

    # Release bolt
    arm.exec_gripper_cmd(0.07)

    # Return to neutral position
    arm.move_to_neutral()