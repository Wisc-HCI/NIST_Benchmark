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
apt-get update
apt install python3-catkin-tools 
pip install panda-robot

cd src/relaxed_ik_ros1/relaxed_ik_core
cargo build
cd /workspace
source /opt/ros/noetic/setup.sh
rm -f src/CMakeLists.txt 
catkin_init_workspace src
catkin build
source devel/setup.sh
```


```bash
source /opt/ros/$ROS_DISTRO/setup.bash
catkin build # if catkin not found, install catkin tools (apt install python-catkin-tools)
source devel/setup.bash
```

Change the "your_ip"  values in franka.sh (specified in that file). You can use [this website](https://whatismyipaddress.com/) to find your IP. Then run the following to set up your environment

```bash

```

## Running

```bash
# Start the driver
./franka.sh master
roslaunch franka_interface interface.launch # (use argument load_gripper:=false for starting without gripper)

# In antoerh terminal do the following:
./franka.sh master

```



## Resources
https://github.com/justagist/franka_ros_interface?tab=readme-ov-file