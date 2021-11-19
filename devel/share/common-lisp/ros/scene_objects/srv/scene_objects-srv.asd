
(cl:in-package :asdf)

(defsystem "scene_objects-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "AddObjects" :depends-on ("_package_AddObjects"))
    (:file "_package_AddObjects" :depends-on ("_package"))
  ))