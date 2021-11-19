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

      // Joints
      // Right
      this->jointR1x_ = this->model->GetJoint("jRightShoulder_rotx");
      this->jointR1y_ = this->model->GetJoint("jRightShoulder_roty");
      this->jointR1z_ = this->model->GetJoint("jRightShoulder_rotz");

      this->jointR2y_ = this->model->GetJoint("jRightElbow_roty");
      this->jointR2z_ = this->model->GetJoint("jRightElbow_rotz");
      
      // Left
      this->jointL1x_ = this->model->GetJoint("jLeftShoulder_rotx");
      this->jointL1y_ = this->model->GetJoint("jLeftShoulder_roty");
      this->jointL1z_ = this->model->GetJoint("jLeftShoulder_rotz");

      this->jointL2y_ = this->model->GetJoint("jLeftElbow_roty");
      this->jointL2z_ = this->model->GetJoint("jLeftElbow_rotz");


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
      //current_pose = this->model->WorldPose();
      //center = current_pose.Pos();

      if ((world_->RealTime() - previous_time) > 1.0)
        {
          index = rand() % vlist.size();
          v_x = vlist[index];
          //this->p_x += 0.01; 
          
          //this->jointL1x_->SetParam("fmax", 0, 100.0);
          //this->jointL1x_->SetParam("vel", 0, 1.0);
          //this->jointR1x_->SetVelocity(0, v_x);
          previous_time = world_->RealTime();
        }

      this->p_x += 0.01; 
      this->jointL1x_->SetPosition(0, this->p_x);

      // this->jointR1x_->SetVelocity(0, v_x);
      // this->jointR1y_->SetVelocity(0, v_x);
      // this->jointR1z_->SetVelocity(0, v_x);

      // this->jointR2y_->SetVelocity(0, v_x);
      // this->jointR2z_->SetVelocity(0, v_x);

      //  this->jointL1x_->SetVelocity(0, v_x);
      //  this->jointL1y_->SetVelocity(0, v_x);
      //  this->jointL1z_->SetVelocity(0, v_x);

      // this->jointL2y_->SetVelocity(0, v_x);
      // this->jointL2z_->SetVelocity(0, v_x);
      //this->model->SetLinearVel(ignition::math::Vector3d(v_x, v_y, v_z));
      //this->model->SetAngularVel(ignition::math::Vector3d(0, 0, 0.2));


    }

    // Pointer to the model
    private: 
      int index;
      physics::ModelPtr model;
      gazebo::physics::WorldPtr world_;
      common::Time previous_time;
      float v_x;
      float v_y;
      float v_z;
      float v_low_limit = -0.05;
      float v_up_limit = 0.05;

      float p_x;

      std::vector<float> vlist{-0.5, 0.0, 0.5};
      ignition::math::Pose3d current_pose;
      ignition::math::Vector3d center;

    // Joints
    private:
      // Right 
      physics::JointPtr jointR1x_;
      physics::JointPtr jointR1y_;
      physics::JointPtr jointR1z_;

      physics::JointPtr jointR2y_;
      physics::JointPtr jointR2z_;

      // Left
      physics::JointPtr jointL1x_;
      physics::JointPtr jointL1y_;
      physics::JointPtr jointL1z_;

      physics::JointPtr jointL2y_;
      physics::JointPtr jointL2z_;
    // Pointer to the update event connection
    private: event::ConnectionPtr updateConnection;
  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(ModelPush)
}
