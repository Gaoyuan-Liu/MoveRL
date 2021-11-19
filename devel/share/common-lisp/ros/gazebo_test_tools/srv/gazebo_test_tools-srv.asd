
(cl:in-package :asdf)

(defsystem "gazebo_test_tools-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "RecognizeGazeboObject" :depends-on ("_package_RecognizeGazeboObject"))
    (:file "_package_RecognizeGazeboObject" :depends-on ("_package"))
  ))