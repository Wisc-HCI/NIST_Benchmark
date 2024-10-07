// // Copyright (c) 2017 Franka Emika GmbH
// // Use of this source code is governed by the Apache-2.0 license, see LICENSE
// #include <franka_test/joint_position_controller.h>

// #include <cmath>

// #include <controller_interface/controller_base.h>
// #include <hardware_interface/hardware_interface.h>
// #include <hardware_interface/joint_command_interface.h>
// #include <pluginlib/class_list_macros.h>
// #include <ros/ros.h>
// #include <iostream>

// #include <ros/ros.h>
// #include <geometry_msgs/Pose.h>
// #include <relaxed_ik_ros1/IKPose.h>
// #include <relaxed_ik_ros1/IKPoseRequest.h>
// #include <relaxed_ik_ros1/IKPoseResponse.h>

// namespace franka_test {

// bool JointPositionController::init(hardware_interface::RobotHW* robot_hardware,
//                                           ros::NodeHandle& node_handle) {

//   // Setup
//   position_joint_interface_ = robot_hardware->get<hardware_interface::PositionJointInterface>();
//   if (position_joint_interface_ == nullptr) {
//     ROS_ERROR(
//         "JointPositionController: Error getting position joint interface from hardware!");
//     return false;
//   }
//   std::vector<std::string> joint_names;
//   if (!node_handle.getParam("joint_names", joint_names)) {
//     ROS_ERROR("JointPositionController: Could not parse joint names");
//   }
//   if (joint_names.size() != 7) {
//     ROS_ERROR_STREAM("JointPositionController: Wrong number of joint names, got "
//                      << joint_names.size() << " instead of 7 names!");
//     return false;
//   }
//   position_joint_handles_.resize(7);
//   for (size_t i = 0; i < 7; ++i) {
//     try {
//       position_joint_handles_[i] = position_joint_interface_->getHandle(joint_names[i]);
//     } catch (const hardware_interface::HardwareInterfaceException& e) {
//       ROS_ERROR_STREAM(
//           "JointPositionController: Exception getting joint handles: " << e.what());
//       return false;
//     }

//   }

//   // std::array<double, 7> q_start{{0, -M_PI_4, 0, -3 * M_PI_4, 0, M_PI_2, M_PI_4}};
//   // for (size_t i = 0; i < q_start.size(); i++) {
//   //   if (std::abs(position_joint_handles_[i].getPosition() - q_start[i]) > 0.1) {
//   //     ROS_ERROR_STREAM(
//   //         "JointPositionController: Robot is not in the expected starting position for "
//   //         "running this example. Run `roslaunch franka_test move_to_start.launch "
//   //         "robot_ip:=<robot-ip> load_gripper:=<has-attached-gripper>` first.");
//   //     return false;
//   //   }
//   // }

//   return true;
// }

// void JointPositionController::starting(const ros::Time& /* time */) {

//   geometry_msgs::Pose desired_pose;
//   desired_pose.position.x = 0.5;
//   desired_pose.position.y = 0.0;
//   desired_pose.position.z = 0.5;
//   desired_pose.orientation.x = 1;
//   desired_pose.orientation.y = 0.0;
//   desired_pose.orientation.z = 0.0;
//   desired_pose.orientation.w = 0.0;

//   // Create a service client to request IK solutions
//   ros::NodeHandle nh;
//   ros::ServiceClient client = nh.serviceClient<relaxed_ik_ros1::IKPose>("relaxed_ik/solve_pose");
//   ros::service::waitForService("relaxed_ik/solve_pose");

//   // Prepare the IKPose request and response objects
//   relaxed_ik_ros1::IKPose srv;
//   srv.request.ee_poses.push_back(desired_pose);

//   // Call the service and process the response
//   if (client.call(srv)) {
//       // Print out the IK solution (Joint Configuration)
      
//       ROS_INFO_STREAM("Calculated Joint Configuration:" << srv.response);
  
//       for (size_t i = 0; i < 7; ++i) {
//         joint_goals[i] = srv.response.joint_state[i];
//       }
//   }
//   else ROS_ERROR("Failed to call IK service");

//   for (size_t i = 0; i < 7; ++i) {
//     initial_pose_[i] = position_joint_handles_[i].getPosition();
//   }
//   elapsed_time_ = ros::Duration(0.0);
//   //joint_goals = 2.1;

//   // joint_goals = {{0, -M_PI_4, 0, -3 * M_PI_4, 0, M_PI_2, M_PI_4}}; // Initial pos
//   joint_goals = {{0.5, -0.7, 0.01, -2.3, 0.13, 1.4, 1.3}};
//   // [ INFO] [1726870558.504259858]: Joint 0: 0.5336
//   // [ INFO] [1726870558.504346459]: Joint 1: -0.728685
//   // [ INFO] [1726870558.504385946]: Joint 2: 0.00469184
//   // [ INFO] [1726870558.504408504]: Joint 3: -2.31191
//   // [ INFO] [1726870558.504432694]: Joint 4: 0.139497
//   // [ INFO] [1726870558.504452743]: Joint 5: 1.42993
//   // [ INFO] [1726870558.504469717]: Joint 6: 1.34998
  
//   //joint_goals = {{0, -M_PI_4, 0, -1.3, 0, 3.5, M_PI_4}}; // Rads, almost veritcal
//   //joint_goals = {{-0.19418254089403628, -0.9555199928276591, 0.1781300756198672, -3.0718, 0.16989313282837123, 2.034388729388579, 0.5908506680005838}};

//   // Calculate how long each joint should run based on velocity and initial position
//   for (size_t i = 0; i < 7; ++i) {
//     max_time_seconds[i] = fabs(joint_goals[i] - initial_pose_[i]) / VELOCITY;
    
//   }
// }

// void JointPositionController::update(const ros::Time& /*time*/,
//                                             const ros::Duration& period) {
//   elapsed_time_ += period;

//   float next_position;
//   int direction_multiplier;
//   for (size_t i = 0; i < 7; ++i) {
    
//     direction_multiplier = 1;
//     if (joint_goals[i] < initial_pose_[i]) direction_multiplier = -1;
  
//     next_position = (elapsed_time_.toSec() * VELOCITY + period.toSec()) * direction_multiplier + initial_pose_[i];
    
//     if (elapsed_time_.toSec() <= max_time_seconds[i]) {
//       position_joint_handles_[i].setCommand(next_position);
//       ROS_INFO_STREAM("Joint " << i <<": " << next_position);
//       // ROS_INFO_STREAM("next_pos " << next_position << " | current_position " << current_position << " | step " << step);
//     }

//   }
  
  


  

//   // for (size_t i = 0; i < 7; ++i) {
//   //   if (i == 2) {
//   //     position_joint_handles_[i].setCommand(initial_pose_[i] - delta_angle);
      
//   //   } else {
//   //     position_joint_handles_[i].setCommand(initial_pose_[i] + delta_angle);
//   //   }
//   // }
// }

// }  // namespace franka_test

// PLUGINLIB_EXPORT_CLASS(franka_test::JointPositionController,
//                        controller_interface::ControllerBase)


// Copyright (c) 2017 Franka Emika GmbH
// Use of this source code is governed by the Apache-2.0 license, see LICENSE
#include <franka_test/joint_position_controller.h>

#include <cmath>

#include <controller_interface/controller_base.h>
#include <hardware_interface/hardware_interface.h>
#include <hardware_interface/joint_command_interface.h>
#include <pluginlib/class_list_macros.h>
#include <ros/ros.h>
#include <franka/gripper_state.h>
#include <franka_gripper/franka_gripper.h>
#include <franka_msgs/FrankaState.h>

#include <iostream>
#include <thread>

#include <franka/exception.h>
// #include <franka/vacuum_gripper.h>

namespace franka_test {

using franka_gripper::homing;
using franka_gripper::HomingAction;
using franka_gripper::HomingGoalConstPtr;
using franka_gripper::HomingResult;

// using franka_gripper::move;
// using franka_gripper::MoveAction;
// using franka_gripper::MoveGoalConstPtr;
// using franka_gripper::MoveResult;
// using franka::VacuumGripper;
// using franka::VacuumGripperState;

bool JointPositionController::init(hardware_interface::RobotHW* robot_hardware,
                                          ros::NodeHandle& node_handle) {

  // Check if I can create the vac here. 
  // franka::VacuumGripper vacuum_gripper("192.168.0.198");
  // franka::VacuumGripperState vacuum_gripper_state = vacuum_gripper.readOnce();
  // std::cout << "***********Initial vacuum gripper state: " << vacuum_gripper_state << std::endl;
  // std::cout << "Aftr the init state has been got!" << std::endl;

  // if (!vacuum_gripper.vacuum(100, std::chrono::milliseconds(1000))) {
  //     std::cout << "Failed to vacuum the object." << std::endl;
  //     return -1;
  // }

  this->first_sample_taken = false;
  // TODO: create a subscriber and callback so I can control the joint vel from a ros topic
  // sub_command_ = node_handle.subscribe<sensor_msgs::JointState>(
  //                 "/relaxed_ik/joint_angle_solutions", 1, &JointPositionController::jointCommandCb, this); 
  sub_command_ = node_handle.subscribe<sensor_msgs::JointState>(
                  "/joint_angles", 1, &JointPositionController::jointCommandCb, this); 
  last_time_called = ros::Time::now().toSec();

  velocity_joint_interface_ = robot_hardware->get<hardware_interface::VelocityJointInterface>();
  if (velocity_joint_interface_ == nullptr) {
    ROS_ERROR(
        "JointPositionController: Error getting velocity joint interface from hardware!");
    return false;
  }

  std::string arm_id = "panda";
  // if (!node_handle.getParam("arm_id", arm_id)) {
  //   ROS_ERROR("JointPositionController: Could not get parameter arm_id");
  //   return false;
  // }

  std::vector<std::string> joint_names;
  if (!node_handle.getParam("joint_names", joint_names)) {
    ROS_ERROR("JointPositionController: Could not parse joint names");
  }
  if (joint_names.size() != 7) {
    ROS_ERROR_STREAM("JointPositionController: Wrong number of joint names, got "
                     << joint_names.size() << " instead of 7 names!");
    return false;
  }
  velocity_joint_handles_.resize(7);
  for (size_t i = 0; i < 7; ++i) {
    try {
      velocity_joint_handles_[i] = velocity_joint_interface_->getHandle(joint_names[i]);
    } catch (const hardware_interface::HardwareInterfaceException& ex) {
      ROS_ERROR_STREAM(
          "JointPositionController: Exception getting joint handles: " << ex.what());
      return false;
    }
  }

  auto state_interface = robot_hardware->get<franka_hw::FrankaStateInterface>();
  if (state_interface == nullptr) {
    ROS_ERROR("JointPositionController: Could not get state interface from hardware");
    return false;
  }

  try {
        state_handle_ = std::make_unique<franka_hw::FrankaStateHandle>(
            state_interface->getHandle(arm_id + "_robot"));
  } catch (hardware_interface::HardwareInterfaceException& ex) {
        ROS_ERROR_STREAM(
            "PandaJointVelocityController: Exception getting state handle from interface: " << ex.what());
        return false;
  }

  return true;
}

void JointPositionController::jointCommandCb(const sensor_msgs::JointState::ConstPtr& joint_pos_commands) {
    for (int i = 0; i < 7; i++) joint_positions_[i] = joint_pos_commands->position[i];
    this->callback_done_once = true;
    this->last_time_called = ros::Time::now().toSec();
    // std::cout << this->last_time_called << std::endl;
}

void JointPositionController::starting(const ros::Time& /* time */) {
  elapsed_time_ = ros::Duration(0.0);
}

void JointPositionController::update(const ros::Time& /* time */,
                                            const ros::Duration& period) {
  franka::RobotState robot_state = state_handle_->getRobotState();
  // Currently just a proportional movement. 
  // I am going to keep track of the diffrence so I can make this a PI loss first.
  // Original -> 0.8
  // increasing p makes it feel a little more snappy. 
  //The following are okay with no overshoot: 1.5, 2.0, 3.0
  // TODO: We need to find the reason why there is a little grinding. 
  // Most likely need to smooth out some variable
  elapsed_time_ += period;
  if ((ros::Time::now().toSec() - this->last_time_called) > 3) {
        for (int i = 0; i < 7; i++) velocity_joint_handles_[i].setCommand(0.0);
        // std::cout << "Set Vel to ZERO ******" << std::endl;

  } else if(this->callback_done_once) {  // If command recieved, send the command to the controller
        for (int i = 0; i < 7; i++) {
          // std::cout << "HERE ******" << std::endl;
            this->curr_error_[i] = (joint_positions_[i] - robot_state.q[i]);
            double proportional = this->p_ * this->curr_error_[i];

            if(!this->first_sample_taken){
              this->first_sample_taken = true;
              velocity_joint_handles_[i].setCommand(proportional);
            }else{
              double deriv = this->d_ * (this->curr_error_[i] - this->prev_error_[i]);
              velocity_joint_handles_[i].setCommand(proportional);
            }

            // Always set the previous error value
            this->prev_error_[i] = (joint_positions_[i] - robot_state.q[i]);
        }
  }
  else{
      for (int i = 0; i < 7; i++) velocity_joint_handles_[i].setCommand(0.0);
  }
}

void JointPositionController::stopping(const ros::Time& /*time*/) {
  // WARNING: DO NOT SEND ZERO VELOCITIES HERE AS IN CASE OF ABORTING DURING MOTION
  // A JUMP TO ZERO WILL BE COMMANDED PUTTING HIGH LOADS ON THE ROBOT. LET THE DEFAULT
  // BUILT-IN STOPPING BEHAVIOR SLOW DOWN THE ROBOT.
}

}  // namespace franka_example_controllers

PLUGINLIB_EXPORT_CLASS(franka_test::JointPositionController,
                       controller_interface::ControllerBase)