#include <stabilizing_control/stabilizing_control.h>


int main(int argc, char **argv)
{
    ros::init(argc,argv,"panda_effortcontrol_taskspace"); // initialize ROS, specify ROS node, and initialize this ROS node
    StabilizingControl stabcontrol("panda_effortcontrol_taskspace");
    ros::Rate loop_rate(stabcontrol.samplingFreq); 
    ros::Time startTime = ros::Time::now();

    while(ros::ok())
    {
        if ((ros::Time::now()-startTime).toSec() <= 10)
        {
            // all reference joint angles = current joint angles
            for (int i=0; i<stabcontrol.q_r.size();i++)
            {
                stabcontrol.q_r[i] = stabcontrol.q[i];
            }
            stabcontrol.PIDcontrol();

            // reference finger displacement = current finger displacement
            for (int i=0; i<stabcontrol.finger_r.size();i++)
            {
                stabcontrol.finger_r[i] = 0.0; //stabcontrol.finger[i];
            }
            stabcontrol.handControl();
            
        }

        else if ((ros::Time::now()-startTime).toSec() > 10)
        {
            // reference end-effector in task space
            stabcontrol.pos_r[0] = 0.2858; // x position
            stabcontrol.pos_r[1] = 0.4451; // y position
            stabcontrol.pos_r[2] = 0.7106; // z position

            stabcontrol.orient_r[0] = 0.6077; // x quaternion
            stabcontrol.orient_r[1] = 0.7544; // y quaternion
            stabcontrol.orient_r[2] = -0.2471; // z quaternion
            stabcontrol.orient_r[3] = 0.0266; // w quaternion

            // inverse kinematics: output = q_r
            stabcontrol.inverseKinematics(); 

            // reference finger displacement
            stabcontrol.finger_r[0] = 0.04;
            stabcontrol.finger_r[1] = 0.04;

            // control
            stabcontrol.PIDcontrol();
            stabcontrol.handControl();
        }

        ros::spinOnce();
        loop_rate.sleep(); 
        
    }
    return 0;
}