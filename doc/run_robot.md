# Moving the Physical the Bot

This uses franka_ros_interface as a controller. For compatibility with franka_ros, we are using the kinetic-devel branch of panda_moveit_config.

## Setup

First set up display forwarding:
```bash
xhost +local:
```

Now  build the container image and start the container. Make sure you are in this directories root directory (NIST_Benchmark). These commands use the current directory as the containers file system so any changes you make to the files on your host machine will be mirrored in the container. These commands also allow the containers display to be forwarded to your host machine so that you can see it.
```bash
sudo docker build -t panda-container .

# Start the container with real-time kernel privileges, mount onto the current directory, and allow display forwarding
sudo docker run -it --privileged --cap-add=SYS_NICE --env DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/workspace --net=host panda-container
```

Now your container should be running and you should be in it's command line. 


Now install setup the dependencies:
```bash
source /opt/ros/noetic/setup.sh
cd src/relaxed_ik_ros1/relaxed_ik_core
cargo build

cd /workspace
catkin build

source devel/setup.sh
chmod +x /workspace/src/franka_test/scripts/
```


Change the "your_ip"  values in franka.sh (specified in that file). You can find your internal ip using `ifconfig` It should be 192.168.1.___.


## Running
Make sure your the joints are unlocked and the FCI IS ENABLED. Then run the following

```bash
# Start the driver
./franka.sh master
roslaunch franka_interface interface.launch 


# In another terminal do the following:
source devel/setup.sh
./franka.sh master
rosrun franka_test move_to_position.py # WARNING: THIS WILL MOVE THE BOT!
```


## Resources
https://github.com/justagist/franka_ros_interface?tab=readme-ov-file
https://github.com/frankaemika/franka_ros/issues/23