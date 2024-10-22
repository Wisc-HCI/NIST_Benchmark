#!/usr/bin/env python3
import os
import csv
from datetime import datetime

import rospy

from panda_robot import PandaArm
from move_to_position import move_to_cartesian_position

		
def move_and_log(arm, x, y, z, action_note):

    file_path = '/workspace/output/accuracy_test.csv'
    fieldnames = ['Trial_Time', 
                'Desired_X', 'Desired_Y', 'Desired_Z', 
                'IK_J0', 'IK_J1', 'IK_J2', 'IK_J3', 'IK_J4', 'IK_J5', 'IK_J6',
                'Actual_J0', 'Actual_J1', 'Actual_J2', 'Actual_J3', 'Actual_J4', 'Actual_J5', 'Actual_J6',
                'Actual_X', 'Actual_Y', 'Actual_Z', 
                'Action'
                ]

    # Only add header if the file is empty
    if os.stat(file_path).st_size == 0:
        with open(file_path, 'w') as csv_file:
            writer = csv.writer(csv_file)
            writer.writerow(fieldnames)
    
    row = [datetime.now().strftime("%Y-%m-%d %H:%M:%S")] # Add time to row


    row += [x, y, z]  # Desired cartesian position
    
    # Move to bolt
    ik_joints = move_to_cartesian_position(arm, 
                              x, y, z, # X, Y, Z in m
                              0, 0.0, 0.0) # Roll, Pitch, Yaw in rads
    
    row += ik_joints  # Joint positions calculated from IK
    row += list(arm.angles()) # Actual Joint angles
    row += list(arm.ee_pose()[0]) # Actual cartesian position
    row += [action_note]

    print(row)

    with open(file_path, 'a') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerows([row])

 
 
if __name__ == '__main__':

    rospy.init_node("panda_demo") # initialise ros node
    arm = PandaArm() 

    for i in range(3):

        arm.exec_gripper_cmd(0.07)
        arm.move_to_neutral()
        
        # Move to bolt
        move_and_log(arm, 0.425, 0.0955, 0.2, "Move to bolt")
        
        # Grab bolt
        arm.exec_gripper_cmd(0.015) 

        # Move up
        move_and_log(arm, 0.425, 0.0955, 0.35, "Move up from bolt")

        # Move across board
        move_and_log(arm, 0.29, -0.21, 0.35, "Move across board")

        # Move down to bolt
        move_and_log(arm, 0.29, -0.21, 0.2, "Move down towards bolt")

        # Release bolt
        arm.exec_gripper_cmd(0.07)

        # Return to neutral position
        arm.move_to_neutral()
