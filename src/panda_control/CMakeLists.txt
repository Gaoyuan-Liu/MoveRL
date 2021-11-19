cmake_minimum_required(VERSION 2.8.3)
project(panda_control)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)
set(CMAKE_CXX_FLAGS "-std=c++14")

find_package(catkin REQUIRED
  std_msgs
  roscpp
  tf
)

find_package(orocos_kdl)
find_package(kdl_parser)
find_package(Eigen3 REQUIRED)

################################################
## Declare ROS messages, services and actions ##
################################################

################################################
## Declare ROS dynamic reconfigure parameters ##
################################################


###################################
## catkin specific configuration ##
###################################

catkin_package()

###########
## Build ##
###########
include_directories(
  include
  ${EIGEN3_INCLUDE_DIR}
)


include_directories(
  SYSTEM ${catkin_INCLUDE_DIRS}
)

add_library(stabilizing_control include/stabilizing_control/stabilizing_control.h
                                                        src/stabilizing_control.cpp)
add_dependencies(stabilizing_control ${catkin_EXPORTED_TARGETS})
target_link_libraries(stabilizing_control ${catkin_LIBRARIES} )

add_executable(panda_positioncontrol_jointspace src/panda_positioncontrol_jointspace.cpp)
target_link_libraries(panda_positioncontrol_jointspace ${catkin_LIBRARIES} )

add_executable(panda_positioncontrol_taskspace src/panda_positioncontrol_taskspace.cpp)
target_link_libraries(panda_positioncontrol_taskspace stabilizing_control
                                                      ${catkin_LIBRARIES} 
                                                      ${kdl_parser_LIBRARIES} 
                                                      ${orocos_kdl_LIBRARIES})

add_executable(panda_effortcontrol_jointspace src/panda_effortcontrol_jointspace.cpp)
target_link_libraries(panda_effortcontrol_jointspace  stabilizing_control
                                                      ${catkin_LIBRARIES} 
                                                      ${kdl_parser_LIBRARIES} 
                                                      ${orocos_kdl_LIBRARIES})

add_executable(panda_effortcontrol_taskspace src/panda_effortcontrol_taskspace.cpp)
target_link_libraries(panda_effortcontrol_taskspace stabilizing_control
                                                    ${catkin_LIBRARIES} 
                                                    ${kdl_parser_LIBRARIES} 
                                                    ${orocos_kdl_LIBRARIES})


#############
## Install ##
#############

install(DIRECTORY config
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

install(DIRECTORY launch
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})