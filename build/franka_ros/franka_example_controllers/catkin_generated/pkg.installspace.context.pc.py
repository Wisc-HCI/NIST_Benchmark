# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include;/usr/include".split(';') if "${prefix}/include;/usr/include" != "" else []
PROJECT_CATKIN_DEPENDS = "controller_interface;dynamic_reconfigure;eigen_conversions;franka_hw;franka_gripper;geometry_msgs;hardware_interface;joint_limits_interface;tf;tf_conversions;message_runtime;pluginlib;realtime_tools;roscpp;urdf;visualization_msgs".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lfranka_example_controllers;/usr/lib/libfranka.so.0.9.2".split(';') if "-lfranka_example_controllers;/usr/lib/libfranka.so.0.9.2" != "" else []
PROJECT_NAME = "franka_example_controllers"
PROJECT_SPACE_DIR = "/workspace/install"
PROJECT_VERSION = "0.9.1"
