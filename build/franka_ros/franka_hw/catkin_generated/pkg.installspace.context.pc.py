# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include;/usr/include".split(';') if "${prefix}/include;/usr/include" != "" else []
PROJECT_CATKIN_DEPENDS = "actionlib_msgs;actionlib;controller_interface;combined_robot_hw;hardware_interface;joint_limits_interface;roscpp;std_srvs;pluginlib;urdf;franka_msgs".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lfranka_hw;-lfranka_control_services;/usr/lib/libfranka.so.0.9.2".split(';') if "-lfranka_hw;-lfranka_control_services;/usr/lib/libfranka.so.0.9.2" != "" else []
PROJECT_NAME = "franka_hw"
PROJECT_SPACE_DIR = "/workspace/install"
PROJECT_VERSION = "0.9.1"
