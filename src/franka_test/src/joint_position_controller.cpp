// Copyright (c) 2017 Franka Emika GmbH
// Use of this source code is governed by the Apache-2.0 license, see LICENSE
#include <franka_test/joint_position_controller.h>

#include <cmath>

#include <controller_interface/controller_base.h>
#include <hardware_interface/hardware_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <pluginlib/class_list_macros.h>
#include <ros/ros.h>
#include <iostream>

#include <ros/ros.h>
#include <geometry_msgs/Pose.h>
#include <relaxed_ik_ros1/IKPose.h>
#include <relaxed_ik_ros1/IKPoseRequest.h>
#include <relaxed_ik_ros1/IKPoseResponse.h>

namespace franka_test {

bool JointPositionController::init(hardware_interface::RobotHW* robot_hardware,
                                          ros::NodeHandle& node_handle) {

  // Setup
  position_joint_interface_ = robot_hardware->get<hardware_interface::PositionJointInterface>();
  if (position_joint_interface_ == nullptr) {
    ROS_ERROR(
        "JointPositionController: Error getting position joint interface from hardware!");
    return false;
  }
  std::vector<std::string> joint_names;
  if (!node_handle.getParam("joint_names", joint_names)) {
    ROS_ERROR("JointPositionController: Could not parse joint names");
  }
  if (joint_names.size() != 7) {
    ROS_ERROR_STREAM("JointPositionController: Wrong number of joint names, got "
                     << joint_names.size() << " instead of 7 names!");
    return false;
  }
  position_joint_handles_.resize(7);
  for (size_t i = 0; i < 7; ++i) {
    try {
      position_joint_handles_[i] = position_joint_interface_->getHandle(joint_names[i]);
    } catch (const hardware_interface::HardwareInterfaceException& e) {
      ROS_ERROR_STREAM(
          "JointPositionController: Exception getting joint handles: " << e.what());
      return false;
    }

  }

  // std::array<double, 7> q_start{{0, -M_PI_4, 0, -3 * M_PI_4, 0, M_PI_2, M_PI_4}};
  // for (size_t i = 0; i < q_start.size(); i++) {
  //   if (std::abs(position_joint_handles_[i].getPosition() - q_start[i]) > 0.1) {
  //     ROS_ERROR_STREAM(
  //         "JointPositionController: Robot is not in the expected starting position for "
  //         "running this example. Run `roslaunch franka_test move_to_start.launch "
  //         "robot_ip:=<robot-ip> load_gripper:=<has-attached-gripper>` first.");
  //     return false;
  //   }
  // }

  return true;
}

void JointPositionController::starting(const ros::Time& /* time */) {

  geometry_msgs::Pose desired_pose;
  desired_pose.position.x = 0.5;
  desired_pose.position.y = 0.0;
  desired_pose.position.z = 0.5;
  desired_pose.orientation.x = 1;
  desired_pose.orientation.y = 0.0;
  desired_pose.orientation.z = 0.0;
  desired_pose.orientation.w = 0.0;

  // Create a service client to request IK solutions
  ros::NodeHandle nh;
  ros::ServiceClient client = nh.serviceClient<relaxed_ik_ros1::IKPose>("relaxed_ik/solve_pose");
  ros::service::waitForService("relaxed_ik/solve_pose");

  // Prepare the IKPose request and response objects
  relaxed_ik_ros1::IKPose srv;
  srv.request.ee_poses.push_back(desired_pose);

  // Call the service and process the response
  if (client.call(srv)) {
      // Print out the IK solution (Joint Configuration)
      
      ROS_INFO_STREAM("Calculated Joint Configuration:" << srv.response);
  
      for (size_t i = 0; i < 7; ++i) {
        joint_goals[i] = srv.response.joint_state[i];
      }
  }
  else ROS_ERROR("Failed to call IK service");

  for (size_t i = 0; i < 7; ++i) {
    initial_pose_[i] = position_joint_handles_[i].getPosition();
  }
  elapsed_time_ = ros::Duration(0.0);
  //joint_goals = 2.1;

  // joint_goals = {{0, -M_PI_4, 0, -3 * M_PI_4, 0, M_PI_2, M_PI_4}}; // Initial pos
  joint_goals = {{0.5, -0.7, 0.01, -2.3, 0.13, 1.4, 1.3}};
  // [ INFO] [1726870558.504259858]: Joint 0: 0.5336
  // [ INFO] [1726870558.504346459]: Joint 1: -0.728685
  // [ INFO] [1726870558.504385946]: Joint 2: 0.00469184
  // [ INFO] [1726870558.504408504]: Joint 3: -2.31191
  // [ INFO] [1726870558.504432694]: Joint 4: 0.139497
  // [ INFO] [1726870558.504452743]: Joint 5: 1.42993
  // [ INFO] [1726870558.504469717]: Joint 6: 1.34998
  
  //joint_goals = {{0, -M_PI_4, 0, -1.3, 0, 3.5, M_PI_4}}; // Rads, almost veritcal
  //joint_goals = {{-0.19418254089403628, -0.9555199928276591, 0.1781300756198672, -3.0718, 0.16989313282837123, 2.034388729388579, 0.5908506680005838}};

  // Calculate how long each joint should run based on velocity and initial position
  for (size_t i = 0; i < 7; ++i) {
    max_time_seconds[i] = fabs(joint_goals[i] - initial_pose_[i]) / VELOCITY;
    
  }
}

void JointPositionController::update(const ros::Time& /*time*/,
                                            const ros::Duration& period) {
  elapsed_time_ += period;

  float next_position;
  int direction_multiplier;
  for (size_t i = 0; i < 7; ++i) {
    
    direction_multiplier = 1;
    if (joint_goals[i] < initial_pose_[i]) direction_multiplier = -1;
  
    next_position = (elapsed_time_.toSec() * VELOCITY + period.toSec()) * direction_multiplier + initial_pose_[i];
    
    if (elapsed_time_.toSec() <= max_time_seconds[i]) {
      position_joint_handles_[i].setCommand(next_position);
      ROS_INFO_STREAM("Joint " << i <<": " << next_position);
      // ROS_INFO_STREAM("next_pos " << next_position << " | current_position " << current_position << " | step " << step);
    }

  }
  
  


  

  // for (size_t i = 0; i < 7; ++i) {
  //   if (i == 2) {
  //     position_joint_handles_[i].setCommand(initial_pose_[i] - delta_angle);
      
  //   } else {
  //     position_joint_handles_[i].setCommand(initial_pose_[i] + delta_angle);
  //   }
  // }
}

}  // namespace franka_test

PLUGINLIB_EXPORT_CLASS(franka_test::JointPositionController,
                       controller_interface::ControllerBase)
