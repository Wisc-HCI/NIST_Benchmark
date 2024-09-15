# ROS Packages
Any code that you write in ROS should be put in a package for usability, compatibiity, and such. 
[This resource](https://wiki.ros.org/ROS/Tutorials/CreatingPackage) goes over general commands for creating a package.

Below are example instructions for initiating our panda_benchmark package with dependencies on franka_ros and relaxed_ik_ros1. This packages is for simple python scripts in the panda_benchmark/scripts folder

```bash
cd src
catkin_create_pkg panda_benchmark std_msgs rospy roscpp franka_ros relaxed_ik_ros1


cd .. # You should now be in the root repo directory
catkin_make
```

In src/panda_benchmark/CMakeLists.txt, make sure the following is uncommented like this:
```bash
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES panda_benchmark
  CATKIN_DEPENDS franka_ros relaxed_ik_ros1 roscpp rospy std_msgs
#  DEPENDS system_lib
)

# ... More stuff here ...
target_link_libraries(${PROJECT_NAME}_node
  ${catkin_LIBRARIES}
)

```


BLah blah
chmod +x ~/catkin_ws/src/my_package/scripts/main.py


If you're using Python scripts, ensure they are installed properly by adding them in the catkin_install_python() function:

cmake
Copy code
catkin_install_python(PROGRAMS scripts/your_script.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)


## Sources
https://stackoverflow.com/questions/32953391/regarding-the-necessity-of-ros-packages
ChatGPT 4