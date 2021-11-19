
(cl:in-package :asdf)

(defsystem "object_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :object_recognition_msgs-msg
               :shape_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Object" :depends-on ("_package_Object"))
    (:file "_package_Object" :depends-on ("_package"))
    (:file "ObjectPose" :depends-on ("_package_ObjectPose"))
    (:file "_package_ObjectPose" :depends-on ("_package"))
  ))