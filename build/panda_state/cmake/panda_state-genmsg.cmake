# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "panda_state: 1 messages, 0 services")

set(MSG_I_FLAGS "-Ipanda_state:/home/liu/MoveRL/src/panda_state/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(panda_state_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg" NAME_WE)
add_custom_target(_panda_state_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "panda_state" "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg" "std_msgs/Float64:std_msgs/Header"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(panda_state
  "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_state
)

### Generating Services

### Generating Module File
_generate_module_cpp(panda_state
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_state
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(panda_state_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(panda_state_generate_messages panda_state_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg" NAME_WE)
add_dependencies(panda_state_generate_messages_cpp _panda_state_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_state_gencpp)
add_dependencies(panda_state_gencpp panda_state_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_state_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(panda_state
  "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_state
)

### Generating Services

### Generating Module File
_generate_module_eus(panda_state
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_state
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(panda_state_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(panda_state_generate_messages panda_state_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg" NAME_WE)
add_dependencies(panda_state_generate_messages_eus _panda_state_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_state_geneus)
add_dependencies(panda_state_geneus panda_state_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_state_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(panda_state
  "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_state
)

### Generating Services

### Generating Module File
_generate_module_lisp(panda_state
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_state
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(panda_state_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(panda_state_generate_messages panda_state_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg" NAME_WE)
add_dependencies(panda_state_generate_messages_lisp _panda_state_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_state_genlisp)
add_dependencies(panda_state_genlisp panda_state_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_state_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(panda_state
  "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_state
)

### Generating Services

### Generating Module File
_generate_module_nodejs(panda_state
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_state
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(panda_state_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(panda_state_generate_messages panda_state_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg" NAME_WE)
add_dependencies(panda_state_generate_messages_nodejs _panda_state_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_state_gennodejs)
add_dependencies(panda_state_gennodejs panda_state_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_state_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(panda_state
  "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float64.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_state
)

### Generating Services

### Generating Module File
_generate_module_py(panda_state
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_state
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(panda_state_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(panda_state_generate_messages panda_state_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/liu/MoveRL/src/panda_state/msg/RobotStates.msg" NAME_WE)
add_dependencies(panda_state_generate_messages_py _panda_state_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(panda_state_genpy)
add_dependencies(panda_state_genpy panda_state_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS panda_state_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_state)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/panda_state
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(panda_state_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_state)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/panda_state
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(panda_state_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_state)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/panda_state
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(panda_state_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_state)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/panda_state
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(panda_state_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_state)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_state\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/panda_state
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(panda_state_generate_messages_py std_msgs_generate_messages_py)
endif()
