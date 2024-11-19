#! /usr/bin/env python3

import rospkg
import rospy
import numpy as np

from timeit import default_timer as timer

from panda_robot import PandaArm


class TorqueController:
    def __init__(self, arm:PandaArm):
        self.arm = arm
        self.time_period = 0.001
        self.timer = rospy.Timer(rospy.Duration(self.time_period), self.timer_callback)
        self.prev_q = np.array(arm.angles()) # Current Position

        #self.q_des = np.array([0, -0.79, 0, -1.3, 0, 3.5, 0.79])  # Desired joint angles (almost vertical)
        self.q_des = np.array([0, -np.pi/4, 0, -2.5 * np.pi/4, 0, np.pi/2, np.pi/4])  # Up a bit
        #self.q_des = np.array([0.3, -0.79, 0, -1.3, 0, 3.5, 0.79])  # Desired joint angles (almost vertical)


    def timer_callback(self, event):
        P = np.array([27.00, 27.00, 27.00, 27.00, 10.00, 5.00, 5.00])  
        D = np.array([5.00, 5.00, 5.00, 5.00, 5.00, 0.5, 0.5])  

        q = np.array(self.arm.angles()) # Angle position in rads
        # TODO: get velocity directly from joints
        dq = (q - self.prev_q) / self.time_period # Angular Velocity  of the joints (estimation)
        e = q - self.q_des # Error
        u = -P * e - D * dq  # numpy array of 7
        print("U:", np.round(u,2))
        print("e:", np.round(e,2))
        self.arm.exec_torque_cmd(list(u))

        self.prev_q = q






if __name__ == '__main__':
    rospy.init_node('TorqueController')
    arm = PandaArm()
    arm.move_to_neutral()
    #arm.move_to_joint_position([-1.5707, -1.5707, 0, -2, 0, 3.5, 0.7854])
    #exit()
    trace_a_line = TorqueController(arm)
    rospy.spin()


    # rospy.init_node("panda_demo") # initialise ros node
    