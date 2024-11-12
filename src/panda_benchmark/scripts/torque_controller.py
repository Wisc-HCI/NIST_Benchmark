#! /usr/bin/env python3

import rospkg
import rospy
import numpy as np

from timeit import default_timer as timer

from panda_robot import PandaArm

class TorqueController:
    def __init__(self, arm:PandaArm):
        self.arm = arm
        self.time_period = 0.1
        self.timer = rospy.Timer(rospy.Duration(self.time_period), self.timer_callback)
        self.prev_q = np.array([0, 0, 0, 0, 0, 0, 0])

        self.q_des = np.array([0, -0.7854, 0, -1.3, 0, 3.5, 0.7854])  # Desired joint angles



    def timer_callback(self, event):
        P = [900.0, 900.0, 900.0, 900.0, 375.0, 225.0, 100.0]
        D = [45.0, 45.0, 45.0, 45.0, 15.0, 15.0, 10.0]

        q = np.array(self.arm.angles()) # Angle position in rads
        dq = (q - self.prev_q) / self.time_period # Angular Velocity  of the joints (estimation)

        u = P * (self.q_des - q ) + D * dq  # numpy array of 7
        print(u)
        self.arm.exec_torque_cmd(list(u))

        self.prev_q = q






if __name__ == '__main__':
    rospy.init_node('TorqueController')
    arm = PandaArm()
    arm.move_to_neutral()
    trace_a_line = TorqueController(arm)
    rospy.spin()


    # rospy.init_node("panda_demo") # initialise ros node
    