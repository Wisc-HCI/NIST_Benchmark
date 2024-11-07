
#! /usr/bin/env python3

import rospkg
import rospy

from timeit import default_timer as timer

from panda_robot import PandaArm

class TorqueController:
    def __init__(self):
        arm = PandaArm() 
        self.timer = rospy.Timer(rospy.Duration(0.1), self.timer_callback)




    def timer_callback(self, event):
       
       pass





if __name__ == '__main__':
    rospy.init_node('LineTracing')
    trace_a_line = TorqueController()
    rospy.spin()


    # rospy.init_node("panda_demo") # initialise ros node
    