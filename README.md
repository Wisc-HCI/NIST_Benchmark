# NIST_Benchmark
 [NIST Benchmark](https://www.nist.gov/el/intelligent-systems-division-73500/robotic-grasping-and-manipulation-assembly/assembly) testing with the Franka Emika Panda.

## Setup

For all the steps in this readme, we recommend using Ubuntu 22.04 since that is the only OS that these instructions are tested on.

You will need to install docker so you can run our container. If you are using Ubuntu, you can install docker with [these instructions](https://docs.docker.com/engine/install/ubuntu/#installation-methods): 


## Visualization

We're using RVIZ for visualizations. To run it we've made a container for all the dependencies. 


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
catkin_make 
source devel/setup.sh
```

And run the visualization:
```bash
roslaunch relaxed_ik_ros1 demo.launch setting_file_path:=/workspace/src/panda.yaml
```


## Resources
Source of RelaxedIK (Panda URDF has been midly modified):
https://github.com/uwgraphics/relaxed_ik_ros1

More detailed instructions that help with installing RelaxedIK ROS1:
https://github.com/uwgraphics/relaxed_ik_ros2 


Source of franka_description:
https://github.com/frankaemika/franka_ros/tree/develop/franka_description