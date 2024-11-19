#! /usr/bin/env python3

import rospkg
import rospy
import numpy as np

from timeit import default_timer as timer

from panda_robot import PandaArm


from ik import get_cartesian_position

class TrajectoryFollower:
    def __init__(self, arm:PandaArm):
        self.arm = arm
        self.time_period = 0.001 # Seconds
        self.controller_timer = rospy.Timer(rospy.Duration(self.time_period), self.controller_callback)
        
        #self.q_des = np.array([0, -0.79, 0, -1.3, 0, 3.5, 0.79])  # Desired joint angles (almost vertical)
        self.prev_q = np.array(arm.angles())
        self.q_des = self.prev_q


    def controller_callback(self, event):
        P = np.array([27.00, 27.00, 27.00, 27.00, 10.00, 5.00, 5.00])  
        D = np.array([5.00, 5.00, 5.00, 5.00, 5.00, 0.5, 0.5])  
        
        q = np.array(self.arm.angles()) # Angle position in rads
        dq = (q - self.prev_q) / self.time_period # Angular Velocity  of the joints (estimation)
        e = q - self.q_des # Error
        u = -P * e - D * dq  # numpy array of 7
        print("U:", np.round(u,2))
        print("e:", np.round(e,2))
        self.arm.exec_torque_cmd(list(u))

        self.prev_q = q


    # TODO: linear interpolate role, pitch and yaw
    def linear_interpolate(self,
        curr_x:float, curr_y:float, curr_z:float,  
        final_x:float, final_y:float, final_z:float,
        step_size:float = 0.0001):
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
    
    def start_trajectory(self, x, y, z, roll, pitch, yaw):

        velocity = 0.05 # Meter/second
        interpolation_step_size = 0.05
        time_period = interpolation_step_size / velocity 

        curr_x = self.arm.ee_pose()[0][0]
        curr_y = self.arm.ee_pose()[0][1]
        curr_z = self.arm.ee_pose()[0][2]

        # TODO: pass to callback instead??
        self.trajectory = self.linear_interpolate(curr_x, curr_y, curr_z, x, y, z, interpolation_step_size)
        self.i_traj = 0
        self.roll = roll
        self.pitch = pitch
        self.yaw = yaw

        self.timer = rospy.Timer(rospy.Duration(time_period), self.position_update_callback)


    def position_update_callback(self, event):

        position = self.trajectory[self.i_traj]
        q = get_cartesian_position( position[0], position[1], position[2], # X, Y, Z in m
                                    self.roll, self.pitch, self.yaw) # Roll, Pitch, Yaw in rads`
        self.q_des = np.array(q)
        print("i:", self.i_traj)
        self.i_traj += 1

        if (self.i_traj >= len(self.trajectory)):
            print("MADE IT HERE")
            self.timer.shutdown()






if __name__ == '__main__':
    rospy.init_node('TrajectoryFollower')
    arm = PandaArm()
    arm.move_to_neutral()

    traj = TrajectoryFollower(arm)
    traj.start_trajectory( 0.425, 0.0955, 0.2, 0, 0, 0)
    rospy.spin()


    # rospy.init_node("panda_demo") # initialise ros node
    