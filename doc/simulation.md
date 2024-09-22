# Simulating the Bot
In order to simulate the bot using Gazebo and RVIZ, follow the instructions below


## Setup

First set up display forwarding:
```bash
xhost +local:
```

Now  build the container image and start the container. Make sure you are in this directories root directory (NIST_Benchmark). These commands use the current directory as the containers file system so any changes you make to the files on your host machine will be mirrored in the container. TJese commands also allow the containers display to be forwarded to your host machine so that you can see it.
```bash
sudo docker build -t panda-container .
sudo docker run -it --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-container
```

Now your container should be running and you should be in it's command line. So in the container's terminal, setup the visualization:
```bash
cd src/relaxed_ik_ros1/relaxed_ik_core
cargo build
cd /workspace
source /opt/ros/noetic/setup.sh
rm -f src/CMakeLists.txt 
catkin_init_workspace src
catkin_make
source devel/setup.sh
```

## Running
This code runs a custom controller we wrote that moves the robot from it's inital position to a vertical positon:
```bash

roslaunch relaxed_ik_ros1 ik.launch setting_file_path:=/workspace/src/panda.yaml  # TODO: Put this in franka_test???


# Run this in another terminal (hint: open another docker terminal using instructions in README.md)
# If you run into error while doing this, run `export LIBGL_ALWAYS_SOFTWARE=1`
roslaunch franka_gazebo panda.launch controller:=joint_position_controller rviz:=true


# Other controller:
# roslaunch franka_gazebo panda.launch x:=-0.5 world:=$(rospack find franka_gazebo)/world/stone.sdf controller:=cartesian_variable_impedance_controller rviz:=true

roslaunch franka_gazebo panda.launch controller:=cartesian_variable_impedance_controller rviz:=true

rostopic pub -1 /equilibrium_pose  geometry_msgs/PoseStamped -- 'pose: [[0.5, 0, 0.5], [1,1,0,0]]'


#rosrun frank_human_friendly_controller main_lfd.py 
# pip install pynput
# pip install numpy-quaternion
# python3 src/franka_human_friendly_controllers/python/LfD/main_lfd.py

roslaunch franka_gazebo panda.launch controller:=joint_variable_impedance_controller rviz:=true

rostopic pub -1 /equilibrium_configuration  geometry_msgs/PoseStamped -- 'pose: [[0.5, 0, 0.5], [1,1,0,0]]' # This doesn't work very well for some reason, maybe IK is off?

rostopic pub -1 /equilibrium_configuration  sensor_msgs/JointState -- 'position: [0, 1, 0, 0, 0, 0, 0]'

rostopic pub -1 /equilibrium_configuration  sensor_msgs/JointState -- 'position: [0, -M_PI_4, 0, -3 * M_PI_4, 0, M_PI_2, M_P]'

# Move to default position
rostopic pub -1 /equilibrium_configuration  sensor_msgs/JointState -- '{position: [0, -0.785, 0, -2.356, 0, 1.57, 3.14], velocity: [0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001]}'
 

#ros2 topic pub /robot/drive_power custom_msgs_srvs/msg/DrivePower "{left_power:10, right_power:10}"

# Get joint stiffness
rosrun dynamic_reconfigure dynparam get /dynamic_reconfigure_compliance_param_node
# MAX stiffness:
# {'joint_1': 600.0, 'joint_2': 600.0, 'joint_3': 600.0, 'joint_4': 600.0, 'joint_5': 250.0, 'joint_6': 150.0, 'joint_7': 50.0, 'damping_ratio': 1.0, 'groups': {'id': 0, 'parent': 0, 'name': 'Default', 'type': '', 'state': True, 'groups': {}, 'parameters': {}, 'joint_1': 600.0, 'joint_2': 600.0, 'joint_3': 600.0, 'joint_4': 600.0, 'joint_5': 250.0, 'joint_6': 150.0, 'joint_7': 50.0, 'damping_ratio': 1.0}}

# Set joint stiffness
rosrun dynamic_reconfigure dynparam set /dynamic_reconfigure_compliance_param_node "{joint_1: 100, joint_2: 100, joint_3: 100, joint_4: 100, joint_5: 100, joint_6: 100, joint_7: 20}"



```


## Writing more controlers

If you want to write your own controller, TODOD yaml, xml, etc....

You will also need to add your controller configuration to `franka_ros/franka_gazebo/config/sim_controllers.yaml`. For example, this is the configs for joint_position_controller:

```bash
joint_position_controller:
    type: franka_test/JointPositionController
    joint_names:
        - $(arg arm_id)_joint1
        - $(arg arm_id)_joint2
        - $(arg arm_id)_joint3
        - $(arg arm_id)_joint4
        - $(arg arm_id)_joint5
        - $(arg arm_id)_joint6
        - $(arg arm_id)_joint7
```

After you make any changes, make sure to rerun `catkin_make`.





______________________

sudo docker run -it --privileged --cap-add=SYS_NICE --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-container

roslaunch franka_test joint_position_controller.launch \
  robot_ip:=192.168.1.2 load_gripper:=false robot:=panda

https://github.com/franzesegiovanni/franka_human_friendly_controllers