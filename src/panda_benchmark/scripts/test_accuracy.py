#!/usr/bin/env python3
import rospy
import csv

from panda_robot import PandaArm
from move_to_position import move_to_cartesian_position

		
if __name__ == '__main__':

    file_name = './output/accuracy_test.csv'
    fieldnames = ['Trial_Time', 
                'Desired_X', 'Desired_Y', 'Desired_Z', 
                'Actual_J0', 'Actual_J1', 'Actual_J2', 'Actual_J3', 'Actual_J4', 'Actual_J5', 'Actual_J6',
                'Actual_X', 'Actual_Y', 'Actual_Z', 
                ]
    with open(file_name, 'w') as csvfile:

        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
    row = []

    rospy.init_node("panda_demo") # initialise ros node
    arm = PandaArm() 

    arm.exec_gripper_cmd(0.07)
    arm.move_to_neutral()

    row += [0.425, 0.0955, 0.2]  # Desired cartesian position
    
    # Move to bolt
    ik_joints = move_to_cartesian_position(arm, 
                              0.425, 0.0955, 0.2, # X, Y, Z in m
                              0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    
    row += ik_joints  # Joint positions calculated from IK
    row += arm.angles() # Actual Joint angles
    row += arm.ee_pose()[0] # Actual cartesian position

    print(row)

    with open(file_name, 'a') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writerows(row)

    exit()

