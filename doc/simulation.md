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

# Run this in another terminal (hint: open another docker terminal using instructions in READM.md)
roslaunch franka_gazebo panda.launch controller:=joint_position_controller rviz:=true

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

roslaunch franka_example_controllers joint_impedance_example_controller.launch \
  robot_ip:=192.168.1.2 load_gripper:=true robot:=panda