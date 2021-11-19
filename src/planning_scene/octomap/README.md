# :camera:
# Octomap

This part import the planning scene with octomap.
* create octomap: molding octomap from urdf;
* load_octomap: loading a pre-created octomap into planning scene;
* octomapping: creating octomap from camera data (PointCloud2). 

## Usage
* Mapping from PC2:
Modify the data topic in octomap_mapping/octomap_server/launch/octomap_mapping.launch, and run:
```
roslaunch octomap_server octomap_mapping.launch
```
* Save octomap:
The octomap generated in rviz will be saved as .bt format in the current location:
```
rosrun octomap_server octomap_saver -f human_octomap.bt
```
* Load octomap;
Modify the path of .bt file in load_octomap/launch/load_octomap.launch, the .bt file will be loaded in rviz as the planning scene:
```
roslaunch load_octomap load_octomap.launch
```

## Install
```
sudo apt-get install ros-noetic-octomap
```