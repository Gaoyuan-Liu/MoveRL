
(cl:in-package :asdf)

(defsystem "gazebo_grasp_plugin-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "GazeboGraspEvent" :depends-on ("_package_GazeboGraspEvent"))
    (:file "_package_GazeboGraspEvent" :depends-on ("_package"))
  ))