#include <functional>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <ignition/math/Vector3.hh>

double fRand(double fMin, double fMax)
{
    double f = (double)rand() / RAND_MAX;
    return fMin + f * (fMax - fMin);
}

namespace gazebo
{
  class ModelPush : public ModelPlugin
  {
    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr /*_sdf*/)
    {
      // Store the pointer to the model
      this->model = _parent;

      // Timer
      world_ = this->model->GetWorld();

      // Listen to the update event. This event is broadcast every
      // simulation iteration.
      this->updateConnection = event::Events::ConnectWorldUpdateBegin(
          std::bind(&ModelPush::OnUpdate, this));

      previous_time = world_->RealTime();
    }


    // Called by the world update start event
    public: void OnUpdate()
    {
      //ignition::math::Pose3d current_pose;
      //ignition::math::Vector3d center;
      current_pose = this->model->WorldPose();
      center = current_pose.Pos();
      rotation = current_pose.Rot();
      euler = rotation.Euler();

      if ((world_->RealTime() - previous_time) > 3.0)
      {
        index = rand() % vlist.size();
        v_x = vlist[index];
        index = rand() % vlist.size();
        v_y = vlist[index];
        index = rand() % vlist.size();
        v_z = vlist[index];

        index = rand() % wlist.size();
        w_x = wlist[index];
        index = rand() % wlist.size();
        w_y = wlist[index];
        index = rand() % wlist.size();
        w_z = wlist[index];

        previous_time = world_->RealTime();
      }
      
      
      // Define bound
      if(center[0] > 0.5){v_x = v_low_limit;}
      if(center[0] < -0.5){v_x = v_up_limit;}
      if(center[1] > 0.5){v_y = v_low_limit;}
      if(center[1] < -0.5){v_y = v_up_limit;}
      if(center[2] > 2.0){v_z = v_low_limit;}
      if(center[2] < 1.2){v_z = v_up_limit;}

      // Set position
      p_x = center[0] + 0.001 * v_x;
      p_y = center[1] + 0.001 * v_y;
      p_z = center[2] + 0.001 * v_z;

      // a_x = euler[0] + 0.001 * w_x;
      // a_y = euler[1] + 0.001 * w_y;
      // a_z = euler[2] + 0.001 * w_z;
      a_x = 0.0;
      a_y = 0.0;
      a_z = 0.0;

      // Avoid the robot
      if(p_x < 0.3 && p_x >= 0 && (p_y < 0.3 && p_y > -0.3)){p_x = 0.3;}
      if(p_x < 0 && p_x > -0.3 && (p_y < 0.3 && p_y > -0.3)){p_x = -0.3;}
      
      // Position command
      this->model->SetWorldPose(ignition::math::Pose3d(p_x, p_y, p_z, a_x, a_y ,a_z));
      //this->model->SetLinearVel(ignition::math::Vector3d(v_x, v_y, v_z));
      //this->model->SetAngularVel(ignition::math::Vector3d(0, 0, w_z));
    }

    // Pointer to the model
    private: 
      physics::ModelPtr model;
      gazebo::physics::WorldPtr world_;
      common::Time previous_time;
      int index;

      float v_x;
      float v_y;
      float v_z;

      float w_x;
      float w_y;
      float w_z;

      float p_x;
      float p_y;
      float p_z;

      float a_x;
      float a_y;
      float a_z;

      float v_low_limit = -0.05;
      float v_up_limit = 0.05;
      
      std::vector<float> vlist{-0.05, 0.0, 0.05};
      std::vector<float> wlist{-0.1, 0.0, 0.1};
      ignition::math::Pose3d current_pose;
      ignition::math::Vector3d center;
      ignition::math::Quaterniond rotation;
      ignition::math::Vector3<double> euler;

    // Pointer to the update event connection
    private: event::ConnectionPtr updateConnection;
  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(ModelPush)
}
