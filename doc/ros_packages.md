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

TODO: COMPLETE THIS BC THIS IS NOT FINISHED