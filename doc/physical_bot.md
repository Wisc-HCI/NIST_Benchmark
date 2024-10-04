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

Now your container should be running and you should be in it's command line. 


Now install setup the dependencies:
```bash

# TODO: MOVE THE FOLLOWING TO DOCKER FILE
# pip install -r src/panda_simulator/requirements.txt 
    # Successfully uninstalled numpy-1.24.4
    # Successfully uninstalled numpy-quaternion-2021.4.5.14.42.35
pip install future
pip install panda_robot  # This is installed locally from source bc there where errors that I had to fix
pip install numpy==1.21 # This is to fix error AttributeError: module 'numpy' has no attribute 'typeDict'

apt-get update
apt install python3-catkin-tools git ros-noetic-gazebo-ros-control ros-noetic-rospy-message-converter ros-noetic-effort-controllers ros-noetic-joint-state-controller ros-noetic-moveit ros-noetic-moveit-commander ros-noetic-moveit-visual-tools


source /opt/ros/noetic/setup.sh
cd src/relaxed_ik_ros1/relaxed_ik_core
cargo build

cd /workspace/src
wstool merge panda_simulator/dependencies.rosinstall

# rm -f src/CMakeLists.txt 
# catkin_init_workspace src
cd /workspace
catkin build
source devel/setup.sh
```


Change the "your_ip"  values in franka.sh (specified in that file). You can use [this website](https://whatismyipaddress.com/) to find your IP. Then run the following to set up your environment

## Running

```bash
# Start the driver
./franka.sh master
roslaunch franka_interface interface.launch # (use argument load_gripper:=false for starting without gripper)

# In another terminal do the following:
./franka.sh master
python3
import rospy
from panda_robot import PandaArm
rospy.init_node("panda_demo") # initialise ros node
r = PandaArm() 
r.move_to_neutral()
r.move_to_joint_position([-8.48556818e-02, -8.88127666e-02, -6.59622769e-01, -1.57569726e+00, -4.82374882e-04,  2.15975946e+00,  4.36766917e-01]) # move robot to the specified pose


```



## Resources
https://github.com/justagist/franka_ros_interface?tab=readme-ov-file


## Ignore:
```bash
[franka <Master> - Robot@192.168.1.2] root@hcilab-G7-7590:/workspace# roslaunch franka_interface interface.launch
... logging to /root/.ros/log/45308a6a-827c-11ef-ab9e-8c04ba9c94a0/roslaunch-hcilab-G7-7590-34350.log
Checking log directory for disk usage. This may take a while.
Press Ctrl-C to interrupt
Done checking log file disk usage. Usage is <1GB.

xacro: in-order processing became default in ROS Melodic. You can drop the option.
No such file or directory: /workspace/src/franka_ros/franka_description/robots/panda/panda.urdf.xacro [Errno 2] No such file or directory: '/workspace/src/franka_ros/franka_description/robots/panda/panda.urdf.xacro'
RLException: while processing /workspace/src/panda_moveit_config/launch/move_group.launch:
while processing /workspace/src/panda_moveit_config/launch/planning_context.launch:
Invalid <param> tag: Cannot load command parameter [robot_description]: command [['xacro', '/workspace/src/franka_ros/franka_description/robots/panda/panda.urdf.xacro', 'hand:=true', 'arm_id:=panda']] returned with code [2]. 

Param xml is <param name="$(arg robot_description)" command="xacro '$(find franka_description)/robots/panda/panda.urdf.xacro' hand:=$(arg load_gripper) arm_id:=$(arg arm_id)" if="$(arg load_robot_description)"/>
The traceback for the exception was written to the log file
```