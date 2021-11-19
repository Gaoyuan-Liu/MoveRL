# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "gazebo_test_tools: 0 messages, 1 services")

set(MSG_I_FLAGS "-Iobject_msgs:/home/liu/MoveRL/src/general-message-pkgs/object_msgs/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Ishape_msgs:/opt/ros/noetic/share/shape_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Iobject_recognition_msgs:/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(gazebo_test_tools_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv" NAME_WE)
add_custom_target(_gazebo_test_tools_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gazebo_test_tools" "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(gazebo_test_tools
  "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gazebo_test_tools
)

### Generating Module File
_generate_module_cpp(gazebo_test_tools
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gazebo_test_tools
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(gazebo_test_tools_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(gazebo_test_tools_generate_messages gazebo_test_tools_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv" NAME_WE)
add_dependencies(gazebo_test_tools_generate_messages_cpp _gazebo_test_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gazebo_test_tools_gencpp)
add_dependencies(gazebo_test_tools_gencpp gazebo_test_tools_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gazebo_test_tools_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(gazebo_test_tools
  "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gazebo_test_tools
)

### Generating Module File
_generate_module_eus(gazebo_test_tools
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gazebo_test_tools
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(gazebo_test_tools_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(gazebo_test_tools_generate_messages gazebo_test_tools_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv" NAME_WE)
add_dependencies(gazebo_test_tools_generate_messages_eus _gazebo_test_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gazebo_test_tools_geneus)
add_dependencies(gazebo_test_tools_geneus gazebo_test_tools_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gazebo_test_tools_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(gazebo_test_tools
  "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gazebo_test_tools
)

### Generating Module File
_generate_module_lisp(gazebo_test_tools
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gazebo_test_tools
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(gazebo_test_tools_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(gazebo_test_tools_generate_messages gazebo_test_tools_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv" NAME_WE)
add_dependencies(gazebo_test_tools_generate_messages_lisp _gazebo_test_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gazebo_test_tools_genlisp)
add_dependencies(gazebo_test_tools_genlisp gazebo_test_tools_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gazebo_test_tools_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(gazebo_test_tools
  "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gazebo_test_tools
)

### Generating Module File
_generate_module_nodejs(gazebo_test_tools
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gazebo_test_tools
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(gazebo_test_tools_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(gazebo_test_tools_generate_messages gazebo_test_tools_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv" NAME_WE)
add_dependencies(gazebo_test_tools_generate_messages_nodejs _gazebo_test_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gazebo_test_tools_gennodejs)
add_dependencies(gazebo_test_tools_gennodejs gazebo_test_tools_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gazebo_test_tools_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(gazebo_test_tools
  "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gazebo_test_tools
)

### Generating Module File
_generate_module_py(gazebo_test_tools
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gazebo_test_tools
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(gazebo_test_tools_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(gazebo_test_tools_generate_messages gazebo_test_tools_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/gazebo-pkgs/gazebo_test_tools/srv/RecognizeGazeboObject.srv" NAME_WE)
add_dependencies(gazebo_test_tools_generate_messages_py _gazebo_test_tools_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gazebo_test_tools_genpy)
add_dependencies(gazebo_test_tools_genpy gazebo_test_tools_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gazebo_test_tools_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gazebo_test_tools)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gazebo_test_tools
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET object_msgs_generate_messages_cpp)
  add_dependencies(gazebo_test_tools_generate_messages_cpp object_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gazebo_test_tools)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gazebo_test_tools
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET object_msgs_generate_messages_eus)
  add_dependencies(gazebo_test_tools_generate_messages_eus object_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gazebo_test_tools)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gazebo_test_tools
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET object_msgs_generate_messages_lisp)
  add_dependencies(gazebo_test_tools_generate_messages_lisp object_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gazebo_test_tools)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gazebo_test_tools
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET object_msgs_generate_messages_nodejs)
  add_dependencies(gazebo_test_tools_generate_messages_nodejs object_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gazebo_test_tools)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gazebo_test_tools\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gazebo_test_tools
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET object_msgs_generate_messages_py)
  add_dependencies(gazebo_test_tools_generate_messages_py object_msgs_generate_messages_py)
endif()
