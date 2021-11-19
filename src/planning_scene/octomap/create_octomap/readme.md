Generate an Octomap from a urdf file
=======================================

[Reference](https://github.com/OctoMap/octomap/wiki/Importing-Data-into-OctoMap)

Scripts to convert a Gazebo world to an Octomap usable by the Octomap ROS node.

## Installation

Download [binvox](https://www.patrickmin.com/binvox/)
to convert `.obj` files to voxels representation `.binvox`.
Make sure the .binvox execute file is in this dir.
```shell script
wget http://www.patrickmin.com/binvox/linux64/binvox?rnd=1520896952313989 -O ~/binvox
chmod 755 binvox
```

Download [binvox2bt](https://manpages.ubuntu.com/manpages/bionic/man1/binvox2bt.1.html)
to convert `.binvox` files to octomap representation.
```shell script
sudo apt install octomap-tools
```

Download [Blender](https://www.blender.org/) to convert `.dae` to `.obj`.
```shell script
sudo apt install blender
```

## How to use

To convert a .urdf to an Octomap usable by the Octomap ROS node,
use the `urdf2oct.sh` script. For example:
```
./urdf2oct.sh test.urdf result.bt
```

## Workflow

URDF -> DAE with collada_urdf package
```
rosrun collada_urdf urdf_to_collada input_file.urdf output_file.dae
```

DAE -> OBJ with Blender

OBJ -> binvox with binvox
```
./binvox -e -fit input_file.obj
```

binvox -> oct tree with binvox2bt
```
binvox2bt --mark-free input_file.binvox
```

## Visualization
Use viewvox to check .binvox file
```
./viewvox x file.binvox
```

To visualize the final output, with octovis.
Download first
```
sudo apt install octovis
```
```
octovis file.binvox.bt
```
