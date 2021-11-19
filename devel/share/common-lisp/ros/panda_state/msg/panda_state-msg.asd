
(cl:in-package :asdf)

(defsystem "panda_state-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "RobotStates" :depends-on ("_package_RobotStates"))
    (:file "_package_RobotStates" :depends-on ("_package"))
  ))