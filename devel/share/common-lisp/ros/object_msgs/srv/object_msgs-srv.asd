
(cl:in-package :asdf)

(defsystem "object_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :object_msgs-msg
)
  :components ((:file "_package")
    (:file "ObjectInfo" :depends-on ("_package_ObjectInfo"))
    (:file "_package_ObjectInfo" :depends-on ("_package"))
    (:file "RegisterObject" :depends-on ("_package_RegisterObject"))
    (:file "_package_RegisterObject" :depends-on ("_package"))
  ))