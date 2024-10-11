# Moving the Physical the Bot

This uses franka_ros_interface as a controller. For compatibility with franka_ros, we are using the kinetic-devel branch of panda_moveit_config.

## Setup

First set up display forwarding:
```bash
xhost +local:
```

Now  build the container image and start the container. Make sure you are in this directories root directory (NIST_Benchmark). These commands use the current directory as the containers file system so any changes you make to the files on your host machine will be mirrored in the container. TJese commands also allow the containers display to be forwarded to your host machine so that you can see it.
```bash
sudo docker build -t panda-container .

# Start the container with real-time kernel privileges, mount onto the current directory, and allow display forwarding
sudo docker run -it --privileged --cap-add=SYS_NICE --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-container

```

Now your container should be running and you should be in it's command line. 


Now install setup the dependencies:
```bash

# TODO: MOVE THE FOLLOWING TO DOCKER FILE
# pip install -r src/panda_simulator/requirements.txt 
    # Successfully uninstalled numpy-1.24.4
    # Successfully uninstalled numpy-quaternion-2021.4.5.14.42.35
pip install future
#pip install panda_robot  # This is installed locally from source bc there where errors that I had to fix
cd panda_robot
python3 setup.py install
cd /workspace
pip install numpy==1.21 # This is to fix error AttributeError: module 'numpy' has no attribute 'typeDict'
pip install numpy-quaternion

#Successfully built numpy-quaternion
#ERROR: panda-robot 0.0.5 has requirement numpy-quaternion==2021.4.5.14.42.35, but you'll have numpy-quaternion 2020.5.11.13.33.35 which is incompatible.

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


Change the "your_ip"  values in franka.sh (specified in that file). You can find your internal ip using `ifconfig` It should be 192.168.1.___.

## Running

```bash
# Start the driver
./franka.sh master
roslaunch franka_interface interface.launch # (use argument load_gripper:=false for starting without gripper)
# Or run with options:
roslaunch franka_interface interface.launch load_demo_planning_scene:=false load_gripper:=false start_controllers:=false start_moveit:=false

# In another terminal do the following:
source devel/setup.sh
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



# Resources
https://github.com/frankaemika/franka_ros/issues/23