// // Copyright (c) 2017 Franka Emika GmbH
// // Use of this source code is governed by the Apache-2.0 license, see LICENSE
// #pragma once

// #include <array>
// #include <string>
// #include <vector>

// #include <controller_interface/multi_interface_controller.h>
// #include <hardware_interface/joint_command_interface.h>
// #include <hardware_interface/robot_hw.h>
// #include <ros/node_handle.h>
// #include <ros/time.h>

// namespace franka_test {

// class JointPositionController : public controller_interface::MultiInterfaceController<
//                                            hardware_interface::PositionJointInterface> {
//  public:
//   bool init(hardware_interface::RobotHW* robot_hardware, ros::NodeHandle& node_handle) override;
//   void starting(const ros::Time&) override;
//   void update(const ros::Time&, const ros::Duration& period) override;

//  private:
//   hardware_interface::PositionJointInterface* position_joint_interface_;
//   std::vector<hardware_interface::JointHandle> position_joint_handles_;
//   ros::Duration elapsed_time_;

//   double VELOCITY = 0.0001; // rad/s
//   std::array<double, 7> joint_goals{};
//   std::array<double, 7> max_time_seconds{}; // Max time that each joint needs to move
//   std::array<double, 7> initial_pose_{};
// };

// }  // namespace franka_test


// Copyright (c) 2017 Franka Emika GmbH
// Use of this source code is governed by the Apache-2.0 license, see LICENSE
#pragma once

#include <string>
#include <vector>

#include <controller_interface/multi_interface_controller.h>
#include <franka_hw/franka_state_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <hardware_interface/robot_hw.h>
#include <ros/node_handle.h>
#include <ros/time.h>
#include <sensor_msgs/JointState.h>

namespace franka_test {

class JointPositionController : public controller_interface::MultiInterfaceController<
                                           hardware_interface::VelocityJointInterface,
                                           franka_hw::FrankaStateInterface> {
 public:
  bool init(hardware_interface::RobotHW* robot_hardware, ros::NodeHandle& node_handle) override;
  void update(const ros::Time&, const ros::Duration& period) override;
  void starting(const ros::Time&) override;
  void stopping(const ros::Time&) override;

 private:
  hardware_interface::VelocityJointInterface* velocity_joint_interface_;
  std::vector<hardware_interface::JointHandle> velocity_joint_handles_;
  ros::Duration elapsed_time_;
  bool first_sample_taken;
  void jointCommandCb(const sensor_msgs::JointState::ConstPtr& joint_pos_commands);
  ros::Subscriber sub_command_;
  std::unique_ptr<franka_hw::FrankaStateHandle> state_handle_;
  int last_time_called;
  // std::array<double, 7> joint_velocities{};
  std::vector<double> joint_positions_{0, -M_PI_4, 0, -1.3, 0, 3.5, M_PI_4};
  float p_ = 1.9;
  float d_ = 0.0;
  // float curr_error_;
  std::vector<double> prev_error_{0,0,0,0,0,0,0};
  std::vector<double> curr_error_{0,0,0,0,0,0,0};
  bool callback_done_once = false;
  // franka::RobotState robot_state 
};

}  // namespace franka_test