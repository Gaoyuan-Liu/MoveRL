#!/bin/bash

# Convert a Gazebo world to an octomap file
# The .bt file can later be imported in ROS for the Octomap node

in=$1
out=$2

if [ -z $3 ]; then
  axis_up="Z"
else
  axis_up=$3
fi

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$out" ] || [ -z "$in" ]; then
  echo 'Convert a Gazebo world to an octomap file compatible with the octomap ROS node\n'
  echo 'Usage: world2oct.sh <input_file.world> <output_file.bt> [axis_up "Z"|"Y"]'
  exit
fi

if [ ! -e $HOME/binvox ]; then
  echo "Unable to locate the binvox executable in the $HOME folder !"
fi

rm ./file.dae ./file.obj ./file.binvox ./file.binvox.bt

# Source the python3 virtual env
source ~/venv3.8/bin/activate
source ~/panda_rl/devel/setup.bash

# Convert urdf to .dae
rosrun collada_urdf urdf_to_collada $in ./file.dae

# Convert from Collada .dae to .obj using Blender
#blender --background --python ${__dir}/blend_convert_to_obj.py -- ./file.dae ./file.obj $axis_up
blender --background --python ${__dir}/blend_convert_to_obj.py -- ./file.dae ./file.obj

# Convert from .obj to voxels with binvox
# Assuming the binvox executable is in $HOME
${__dir}/binvox -e -fit -rotx -down ./file.obj

# Convert from .binvox to octomap .binvox.bt
binvox2bt --mark-free ./file.binvox

# Move the file to the expected output
mv ./file.binvox.bt ${__dir}/../../../maps/$out

# Clean the middle files
rm  ./file.obj ./file.mtl ./file.binvox 