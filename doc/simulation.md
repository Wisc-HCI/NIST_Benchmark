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

## Running
Note: If you get `lbGL error: MESA-LOADER: failed to retrieve device information` and Gazebo does not launch, please run `export LIBGL_ALWAYS_SOFTWARE=1` and you can try running the below commands again.
```bash

roslaunch panda_gazebo panda_world.launch # (use argument load_gripper:=false for starting without gripper; see other available arguments in launch file)


# Run the following in another  terminal to move the bot to a position
python3
import rospy
from panda_robot import PandaArm
rospy.init_node("panda_sim")
#rospy.init_node("panda_demo") # initialise ros node
r = PandaArm() 
r.move_to_neutral()
r.move_to_joint_position([-8.48556818e-02, -8.88127666e-02, -6.59622769e-01, -1.57569726e+00, -4.82374882e-04,  2.15975946e+00,  4.36766917e-01]) # move robot to the specified pose

```


## Resources
https://github.com/justagist/franka_ros_interface?tab=readme-ov-file

