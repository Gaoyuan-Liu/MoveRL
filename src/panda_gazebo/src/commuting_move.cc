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

      if ((world_->RealTime() - previous_time) > 2.0)
      {
      // x bound
      /*if (center[0]>0.5)
      {
        v_x = v_low_limit;
      }
      else if(center[0]>0.0)
      {
        int index = rand() % list.size();
        v_x = list[index];
      }
      else
      {
        v_x = v_up_limit;
      }*/
      // y bound
      if (center[1]>0.5)
      {
        v_y = v_low_limit;
      }
      else if(center[1]>-0.5)
      {
        int index = rand() % list.size();
        v_y = list[index];
      }
      else
      {
        v_y = v_up_limit;
      }
      // z bound
      if (center[2]>1.51)
      {
        v_z = v_low_limit;
      }
      else if(center[2]>1.5)
      {
        int index = rand() % list.size();
        v_z = list[index];
      }
      else
      {
        v_z = v_up_limit;
      }
      

      previous_time = world_->RealTime();
      //printf("%f",center[1]);

      }
      this->model->SetLinearVel(ignition::math::Vector3d(v_x, v_y, v_z));
      //this->model->SetAngularVel(ignition::math::Vector3d(0, 0, 0.2));


    }

    // Pointer to the model
    private: 
      physics::ModelPtr model;
      gazebo::physics::WorldPtr world_;
      common::Time previous_time;
      float v_x;
      float v_y;
      float v_z;
      float v_low_limit = -0.05;
      float v_up_limit = 0.05;
      std::vector<float> list{-0.05, 0.0, 0.05};
      ignition::math::Pose3d current_pose;
      ignition::math::Vector3d center;

    // Pointer to the update event connection
    private: event::ConnectionPtr updateConnection;
  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(ModelPush)
}
