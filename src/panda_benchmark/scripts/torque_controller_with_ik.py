#! /usr/bin/env python3

import rospkg
import rospy
import numpy as np

from timeit import default_timer as timer

from panda_robot import PandaArm
from ik import get_cartesian_position


class TorqueController:
    def __init__(self, arm:PandaArm):
        self.arm = arm
        self.time_period = 0.001
        
        self.prev_q = np.array(arm.angles()) # Current Position
        self.q_des = self.prev_q
        self.Y_des = []

        self.torque_timer = rospy.Timer(rospy.Duration(self.time_period), self.torque_callback)


    def set_cartesian_position(self, X, Y, Z, roll, pitch, yaw):
        ik_period = 0.3
        self.ik_timer = rospy.Timer(rospy.Duration(ik_period), self.ik_callback)
        self.Y_des = [X, Y, Z, roll, pitch, yaw]

    def ik_callback(self, event):
        self.q_des = get_cartesian_position(self.Y_des[0], self.Y_des[1], self.Y_des[2],
                               self.Y_des[3], self.Y_des[4], self.Y_des[5])


    def torque_callback(self, event):
        # Real-Life values
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

    controller = TorqueController(arm)
    controller.set_cartesian_position(0.425, 0.0955, 0.2, # X, Y, Z in m
                              0, 0.0, 0.0)
    rospy.spin()


    # rospy.init_node("panda_demo") # initialise ros node
    