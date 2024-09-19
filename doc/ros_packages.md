# ROS Packages
Any code that you write in ROS should be put in a package for usability, compatibiity, and such. 
[This resource](https://wiki.ros.org/ROS/Tutorials/CreatingPackage) goes over general commands for creating a package.

Below are example instructions for initiating our panda_benchmark package with dependencies on franka_ros and relaxed_ik_ros1. This packages is for simple python scripts in the panda_benchmark/scripts folder

```bash
cd src
catkin_create_pkg panda_benchmark std_msgs rospy roscpp relaxed_ik_ros1 franka_control franka_description franka_example_controllers franka_gripper franka_hw franka_msgs franka_visualization

# Create scripts directory
mkdir -p panda_benchmark/scripts  
# Create any python scripts in the scripts folder

chmod +x /workspace/src/panda_benchmark/scripts/* # Make python files recognizable

cd .. # You should now be in the root repo directory

catkin_make
source devel/setup.sh
```


rosrun panda_benchmark line_tracing.py _tolerances:=[0,0,0,0,0,999]

rosrun panda_benchmark line_tracing.py _tolerances:=[0,0,0,0,0,999]

roslaunch relaxed_ik_ros1 demo.launch setting_file_path:=/workspace/src/panda.yaml



roslaunch franka_gazebo panda.launch rviz:=true

roslaunch franka_gazebo panda.launch x:=-0.5 \
    controller:=cartesian_impedance_example_controller \
    rviz:=true

roslaunch franka_gazebo panda.launch x:=-0.5 \
    controller:=joint_position_example_controller \
    rviz:=true


rosrun panda_benchmark line_tracing.py _tolerances:=[0,0,0,0,0,999] _use_topic_not_service:=true _setting_file_path:=/workspace/src/panda.yaml

rostopic pub -1 /franka_control/error_recovery/goal franka_msgs/ErrorRecoveryActionGoal "{}"


rostopic pub --once /franka_gripper/move/goal franka_gripper/MoveActionGoal "goal: { width: 0.08, speed: 0.1,}"



See the topics:
rostopic list | grep joint_position_example_controller

See message types used by topics:
rostopic type /motion_generators/position/gains/panda_joint1/parameter_updates

See what messages you can send:
rosmsg list

Show message field:
rosmsg show franka_gripper/MoveActionGoal

rostopic pub --once joint_velocity_example_controller/dummy_joint_velocity franka_example_controllers/buki "{delta_theta:[0.0,0.0,0.0,0.0,0.2,0.3,0.3]}"


rostopic pub --once /franka_gripper/move/goal franka_gripper/MoveActionGoal "goal: { width: 0.08, speed: 0.1 }"

rostopic pub  /joint_states sensor_msgs/JointState '{header: {stamp:{ secs: 1190}}, name: ["panda_joint1"], position: [100], velocity: [.5]}' --once



/joint_states -> sensor_msgs/JointState
/franka_state_controller/joint_states -> sensor_msgs/JointState
/franka_state_controller/joint_states_desired -> sensor_msgs/JointState
/motion_generators/position/gains/panda_joint1/parameter_descriptions -> dynamic_reconfigure/ConfigDescription
/motion_generators/position/gains/panda_joint1/parameter_updates -> dynamic_reconfigure/Config



actionlib/TestActionGoal
actionlib/TestGoal
actionlib/TestRequestActionGoal
actionlib/TestRequestGoal
actionlib/TwoIntsActionGoal
actionlib/TwoIntsGoal
actionlib_msgs/GoalID
actionlib_msgs/GoalStatus
actionlib_msgs/GoalStatusArray
actionlib_tutorials/AveragingActionGoal
actionlib_tutorials/AveragingGoal
actionlib_tutorials/FibonacciActionGoal
actionlib_tutorials/FibonacciGoal
control_msgs/FollowJointTrajectoryActionGoal
control_msgs/FollowJointTrajectoryGoal
control_msgs/GripperCommandActionGoal
control_msgs/GripperCommandGoal
control_msgs/JointTrajectoryActionGoal
control_msgs/JointTrajectoryGoal
control_msgs/PointHeadActionGoal
control_msgs/PointHeadGoal
control_msgs/SingleJointPositionActionGoal
control_msgs/SingleJointPositionGoal
franka_gripper/GraspActionGoal
franka_gripper/GraspGoal
franka_gripper/HomingActionGoal
franka_gripper/HomingGoal
franka_gripper/MoveActionGoal
franka_gripper/MoveGoal
franka_gripper/StopActionGoal
franka_gripper/StopGoal
franka_msgs/ErrorRecoveryActionGoal
franka_msgs/ErrorRecoveryGoal
moveit_msgs/ExecuteTrajectoryActionGoal
moveit_msgs/ExecuteTrajectoryGoal
moveit_msgs/MoveGroupActionGoal
moveit_msgs/MoveGroupGoal
moveit_msgs/MoveGroupSequenceActionGoal
moveit_msgs/MoveGroupSequenceGoal
moveit_msgs/PickupActionGoal
moveit_msgs/PickupGoal
moveit_msgs/PlaceActionGoal
moveit_msgs/PlaceGoal
nav_msgs/GetMapActionGoal
nav_msgs/GetMapGoal
object_recognition_msgs/ObjectRecognitionActionGoal
object_recognition_msgs/ObjectRecognitionGoal
relaxed_ik_ros1/EEPoseGoals
relaxed_ik_ros1/EEVelGoals
tf2_msgs/LookupTransformActionGoal
tf2_msgs/LookupTransformGoal
turtle_actionlib/ShapeActionGoal
turtle_actionlib/ShapeGoal


root@pop-os:/workspace# rosnode list
/gazebo
/gazebo_gui
/joint_state_publisher
/panda_controller_spawner
/panda_gripper_spawner
/robot_state_publisher
/rosout
/rviz
root@pop-os:/workspace# rosnode info rviz
--------------------------------------------------------------------------------
Node [/rviz]
Publications: 
 * /clicked_point [geometry_msgs/PointStamped]
 * /equilibrium_pose_marker/feedback [visualization_msgs/InteractiveMarkerFeedback]
 * /initialpose [geometry_msgs/PoseWithCovarianceStamped]
 * /move_base_simple/goal [geometry_msgs/PoseStamped]
 * /rosout [rosgraph_msgs/Log]

Subscriptions: 
 * /clock [rosgraph_msgs/Clock]
 * /equilibrium_pose_marker/update [unknown type]
 * /tf [tf2_msgs/TFMessage]
 * /tf_static [tf2_msgs/TFMessage]

Services: 
 * /rviz/get_loggers
 * /rviz/load_config
 * /rviz/load_config_discarding_changes
 * /rviz/reload_shaders
 * /rviz/save_config
 * /rviz/set_logger_level


contacting node http://pop-os:42319/ ...
Pid: 1369
Connections:
 * topic: /rosout
    * to: /rosout
    * direction: outbound (33747 - 10.141.38.11:39646) [20]
    * transport: TCPROS
 * topic: /clock
    * to: /gazebo (http://pop-os:36681/)
    * direction: inbound (54924 - pop-os:56055) [27]
    * transport: TCPROS
 * topic: /tf
    * to: /robot_state_publisher (http://pop-os:46707/)
    * direction: inbound (43546 - pop-os:35343) [26]
    * transport: TCPROS
 * topic: /tf
    * to: /gazebo (http://pop-os:36681/)
    * direction: inbound (55150 - pop-os:56055) [28]
    * transport: TCPROS
 * topic: /tf_static
    * to: /robot_state_publisher (http://pop-os:46707/)
    * direction: inbound (43560 - pop-os:35343) [25]
    * transport: TCPROS



## Sources
https://stackoverflow.com/questions/32953391/regarding-the-necessity-of-ros-packages
ChatGPT 4



https://docs.ros.org/en/noetic/api/franka_hw/html/annotated.html





-------------------------------------

```bash
roslaunch franka_gazebo panda.launch \
    rviz:=true

# /franka_state_controller/joint_states [TOPIC] -> sensor_msgs/JointState [ message]
# std_msgs/Header header
#   uint32 seq
#   time stamp
#   string frame_id
# string[] name
# float64[] position
# float64[] velocity
# float64[] effort



rostopic pub  /joint_states sensor_msgs/JointState '{header: {stamp:{ secs: 230}}, name: ["panda_joint1"], position: [100], velocity: [.5]}' --once


```