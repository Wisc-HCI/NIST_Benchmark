# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "relaxed_ik_ros1: 2 messages, 2 services")

set(MSG_I_FLAGS "-Irelaxed_ik_ros1:/workspace/src/relaxed_ik_ros1/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Ivisualization_msgs:/opt/ros/noetic/share/visualization_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(relaxed_ik_ros1_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg" NAME_WE)
add_custom_target(_relaxed_ik_ros1_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "relaxed_ik_ros1" "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg" "std_msgs/Header:geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Twist:geometry_msgs/Point:geometry_msgs/Vector3"
)

get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg" NAME_WE)
add_custom_target(_relaxed_ik_ros1_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "relaxed_ik_ros1" "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg" "geometry_msgs/Twist:geometry_msgs/Vector3:std_msgs/Header"
)

get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv" NAME_WE)
add_custom_target(_relaxed_ik_ros1_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "relaxed_ik_ros1" "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Twist:geometry_msgs/Point:geometry_msgs/Vector3"
)

get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv" NAME_WE)
add_custom_target(_relaxed_ik_ros1_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "relaxed_ik_ros1" "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv" "geometry_msgs/Vector3:geometry_msgs/Twist"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_msg_cpp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Services
_generate_srv_cpp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_srv_cpp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Module File
_generate_module_cpp(relaxed_ik_ros1
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/relaxed_ik_ros1
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(relaxed_ik_ros1_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(relaxed_ik_ros1_generate_messages relaxed_ik_ros1_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_cpp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_cpp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_cpp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_cpp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(relaxed_ik_ros1_gencpp)
add_dependencies(relaxed_ik_ros1_gencpp relaxed_ik_ros1_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS relaxed_ik_ros1_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_msg_eus(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Services
_generate_srv_eus(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_srv_eus(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Module File
_generate_module_eus(relaxed_ik_ros1
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/relaxed_ik_ros1
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(relaxed_ik_ros1_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(relaxed_ik_ros1_generate_messages relaxed_ik_ros1_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_eus _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_eus _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_eus _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_eus _relaxed_ik_ros1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(relaxed_ik_ros1_geneus)
add_dependencies(relaxed_ik_ros1_geneus relaxed_ik_ros1_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS relaxed_ik_ros1_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_msg_lisp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Services
_generate_srv_lisp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_srv_lisp(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Module File
_generate_module_lisp(relaxed_ik_ros1
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/relaxed_ik_ros1
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(relaxed_ik_ros1_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(relaxed_ik_ros1_generate_messages relaxed_ik_ros1_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_lisp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_lisp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_lisp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_lisp _relaxed_ik_ros1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(relaxed_ik_ros1_genlisp)
add_dependencies(relaxed_ik_ros1_genlisp relaxed_ik_ros1_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS relaxed_ik_ros1_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_msg_nodejs(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Services
_generate_srv_nodejs(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_srv_nodejs(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Module File
_generate_module_nodejs(relaxed_ik_ros1
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/relaxed_ik_ros1
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(relaxed_ik_ros1_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(relaxed_ik_ros1_generate_messages relaxed_ik_ros1_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_nodejs _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_nodejs _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_nodejs _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_nodejs _relaxed_ik_ros1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(relaxed_ik_ros1_gennodejs)
add_dependencies(relaxed_ik_ros1_gennodejs relaxed_ik_ros1_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS relaxed_ik_ros1_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_msg_py(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Services
_generate_srv_py(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1
)
_generate_srv_py(relaxed_ik_ros1
  "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1
)

### Generating Module File
_generate_module_py(relaxed_ik_ros1
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(relaxed_ik_ros1_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(relaxed_ik_ros1_generate_messages relaxed_ik_ros1_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEPoseGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_py _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/msg/EEVelGoals.msg" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_py _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKPose.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_py _relaxed_ik_ros1_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/workspace/src/relaxed_ik_ros1/srv/IKVelocity.srv" NAME_WE)
add_dependencies(relaxed_ik_ros1_generate_messages_py _relaxed_ik_ros1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(relaxed_ik_ros1_genpy)
add_dependencies(relaxed_ik_ros1_genpy relaxed_ik_ros1_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS relaxed_ik_ros1_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/relaxed_ik_ros1)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/relaxed_ik_ros1
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(relaxed_ik_ros1_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(relaxed_ik_ros1_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET visualization_msgs_generate_messages_cpp)
  add_dependencies(relaxed_ik_ros1_generate_messages_cpp visualization_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/relaxed_ik_ros1)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/relaxed_ik_ros1
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(relaxed_ik_ros1_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(relaxed_ik_ros1_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET visualization_msgs_generate_messages_eus)
  add_dependencies(relaxed_ik_ros1_generate_messages_eus visualization_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/relaxed_ik_ros1)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/relaxed_ik_ros1
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(relaxed_ik_ros1_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(relaxed_ik_ros1_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET visualization_msgs_generate_messages_lisp)
  add_dependencies(relaxed_ik_ros1_generate_messages_lisp visualization_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/relaxed_ik_ros1)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/relaxed_ik_ros1
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(relaxed_ik_ros1_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(relaxed_ik_ros1_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET visualization_msgs_generate_messages_nodejs)
  add_dependencies(relaxed_ik_ros1_generate_messages_nodejs visualization_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/relaxed_ik_ros1
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(relaxed_ik_ros1_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(relaxed_ik_ros1_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET visualization_msgs_generate_messages_py)
  add_dependencies(relaxed_ik_ros1_generate_messages_py visualization_msgs_generate_messages_py)
endif()
