# Panda control package 
This package is required together with the panda_desciption package and the panda_gazebo package to control the Panda robot in Gazebo. 

To control the Panda robot in Gazebo, the existing [ros_control package](http://gazebosim.org/tutorials/?tut=ros_control) is used. 

To be able to control the Panda robot in Gazebo, the [urdf folder](ros_ws/src/panda_description/urdf) in the panda_description package has been adapted such that the actuators are linked to the joints and the [launch folder](ros_ws/src/panda_control/launch) and [package.xml file](ros_ws/src/panda_control/package.xml) have been adapted such that the program can be launched. 


## Position control
The user will be asked to enter a reference in joint space for the Panda arm and a finger displacement for the Panda hand by running  
```bash
roslaunch panda_gazebo panda_sim_positioncontrol.launch
```
The Panda robot will move to this reference configuration by means of position control. 

A config folder is created with a panda_positioncontrol.yaml file in it, that lists the position controllers for the panda hand and arm. 

A launch folder is created with a panda_positioncontrol.launch file in it, which loads te yaml file, the controller_manager that specifies the controllers listed in the yaml file, and the robot_state_publisher. 

## Effort control 
The user will be asked to enter a reference in joint space for the Panda arm and a finger displacement for the Panda hand by running 
```bash
roslaunch panda_gazebo panda_sim_effortcontrol.launch
```
The Panda robot will move to this reference configuration by means of effort control. 

A config folder is created with a panda_effortcontrol.yaml file in it, that lists the effort controllers for the panda hand and arm. 

A launch folder is created with a panda_effortcontrol.launch file in it, which loads te yaml file, the controller_manager that specifies the controllers listed in the yaml file, and the robot_state_publisher. 