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
source /opt/ros/noetic/setup.sh
cd src/relaxed_ik_ros1/relaxed_ik_core
cargo build

cd /workspace
catkin build
source devel/setup.sh
chmod +x /workspace/src/franka_test/scripts/

```

## Running
Note: If you get `lbGL error: MESA-LOADER: failed to retrieve device information` and Gazebo does not launch, please run `export LIBGL_ALWAYS_SOFTWARE=1` and you can try running the below commands again.
```bash
roslaunch panda_gazebo panda_world.launch 


# Run the following in another  terminal to move the bot to a position
rosrun franka_test move_to_position.py 

```


## Resources
https://github.com/justagist/franka_ros_interface?tab=readme-ov-file

