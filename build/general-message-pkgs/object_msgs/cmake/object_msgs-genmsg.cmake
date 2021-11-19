# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "object_msgs: 2 messages, 2 services")

set(MSG_I_FLAGS "-Iobject_msgs:/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Ishape_msgs:/opt/ros/noetic/share/shape_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Iobject_recognition_msgs:/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(object_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg" NAME_WE)
add_custom_target(_object_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "object_msgs" "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg" "std_msgs/Header:shape_msgs/MeshTriangle:geometry_msgs/Pose:shape_msgs/SolidPrimitive:geometry_msgs/Quaternion:shape_msgs/Plane:geometry_msgs/Point:object_recognition_msgs/ObjectType:shape_msgs/Mesh"
)

get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg" NAME_WE)
add_custom_target(_object_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "object_msgs" "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg" "std_msgs/Header:geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/PoseStamped:geometry_msgs/Point"
)

get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv" NAME_WE)
add_custom_target(_object_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "object_msgs" "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv" "std_msgs/Header:shape_msgs/MeshTriangle:object_msgs/Object:geometry_msgs/Pose:shape_msgs/SolidPrimitive:geometry_msgs/Quaternion:shape_msgs/Plane:geometry_msgs/Point:object_recognition_msgs/ObjectType:shape_msgs/Mesh"
)

get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv" NAME_WE)
add_custom_target(_object_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "object_msgs" "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/object_msgs
)
_generate_msg_cpp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/object_msgs
)

### Generating Services
_generate_srv_cpp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/object_msgs
)
_generate_srv_cpp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/object_msgs
)

### Generating Module File
_generate_module_cpp(object_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/object_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(object_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(object_msgs_generate_messages object_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_cpp _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_cpp _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_cpp _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_cpp _object_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(object_msgs_gencpp)
add_dependencies(object_msgs_gencpp object_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS object_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/object_msgs
)
_generate_msg_eus(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/object_msgs
)

### Generating Services
_generate_srv_eus(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/object_msgs
)
_generate_srv_eus(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/object_msgs
)

### Generating Module File
_generate_module_eus(object_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/object_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(object_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(object_msgs_generate_messages object_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_eus _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_eus _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_eus _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_eus _object_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(object_msgs_geneus)
add_dependencies(object_msgs_geneus object_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS object_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/object_msgs
)
_generate_msg_lisp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/object_msgs
)

### Generating Services
_generate_srv_lisp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/object_msgs
)
_generate_srv_lisp(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/object_msgs
)

### Generating Module File
_generate_module_lisp(object_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/object_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(object_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(object_msgs_generate_messages object_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_lisp _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_lisp _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_lisp _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_lisp _object_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(object_msgs_genlisp)
add_dependencies(object_msgs_genlisp object_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS object_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/object_msgs
)
_generate_msg_nodejs(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/object_msgs
)

### Generating Services
_generate_srv_nodejs(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/object_msgs
)
_generate_srv_nodejs(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/object_msgs
)

### Generating Module File
_generate_module_nodejs(object_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/object_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(object_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(object_msgs_generate_messages object_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_nodejs _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_nodejs _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_nodejs _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_nodejs _object_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(object_msgs_gennodejs)
add_dependencies(object_msgs_gennodejs object_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS object_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs
)
_generate_msg_py(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs
)

### Generating Services
_generate_srv_py(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/MeshTriangle.msg;/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/SolidPrimitive.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Plane.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg/ObjectType.msg;/opt/ros/noetic/share/shape_msgs/cmake/../msg/Mesh.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs
)
_generate_srv_py(object_msgs
  "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs
)

### Generating Module File
_generate_module_py(object_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(object_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(object_msgs_generate_messages object_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/Object.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_py _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg/ObjectPose.msg" NAME_WE)
add_dependencies(object_msgs_generate_messages_py _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/ObjectInfo.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_py _object_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/liu/MoveRL/src/general-message-pkgs/object_msgs/srv/RegisterObject.srv" NAME_WE)
add_dependencies(object_msgs_generate_messages_py _object_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(object_msgs_genpy)
add_dependencies(object_msgs_genpy object_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS object_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/object_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/object_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(object_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET shape_msgs_generate_messages_cpp)
  add_dependencies(object_msgs_generate_messages_cpp shape_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(object_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET object_recognition_msgs_generate_messages_cpp)
  add_dependencies(object_msgs_generate_messages_cpp object_recognition_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/object_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/object_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(object_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET shape_msgs_generate_messages_eus)
  add_dependencies(object_msgs_generate_messages_eus shape_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(object_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET object_recognition_msgs_generate_messages_eus)
  add_dependencies(object_msgs_generate_messages_eus object_recognition_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/object_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/object_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(object_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET shape_msgs_generate_messages_lisp)
  add_dependencies(object_msgs_generate_messages_lisp shape_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(object_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET object_recognition_msgs_generate_messages_lisp)
  add_dependencies(object_msgs_generate_messages_lisp object_recognition_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/object_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/object_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(object_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET shape_msgs_generate_messages_nodejs)
  add_dependencies(object_msgs_generate_messages_nodejs shape_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(object_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET object_recognition_msgs_generate_messages_nodejs)
  add_dependencies(object_msgs_generate_messages_nodejs object_recognition_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/object_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(object_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET shape_msgs_generate_messages_py)
  add_dependencies(object_msgs_generate_messages_py shape_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(object_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET object_recognition_msgs_generate_messages_py)
  add_dependencies(object_msgs_generate_messages_py object_recognition_msgs_generate_messages_py)
endif()
