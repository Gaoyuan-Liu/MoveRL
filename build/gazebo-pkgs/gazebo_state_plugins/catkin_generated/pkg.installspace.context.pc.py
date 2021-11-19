# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "geometry_msgs;roscpp;shape_msgs;std_msgs;nav_msgs;gazebo_world_plugin_loader;gazebo_ros;object_msgs;object_msgs_tools;eigen_conversions;gazebo_ros".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lgazebo_state_plugins;-lgazebo_map_publisher".split(';') if "-lgazebo_state_plugins;-lgazebo_map_publisher" != "" else []
PROJECT_NAME = "gazebo_state_plugins"
PROJECT_SPACE_DIR = "/home/liu/MoveRL/install"
PROJECT_VERSION = "1.0.2"
