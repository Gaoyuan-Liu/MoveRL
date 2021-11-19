;; Auto-generated. Do not edit!


(when (boundp 'object_msgs::RegisterObject)
  (if (not (find-package "OBJECT_MSGS"))
    (make-package "OBJECT_MSGS"))
  (shadow 'RegisterObject (find-package "OBJECT_MSGS")))
(unless (find-package "OBJECT_MSGS::REGISTEROBJECT")
  (make-package "OBJECT_MSGS::REGISTEROBJECT"))
(unless (find-package "OBJECT_MSGS::REGISTEROBJECTREQUEST")
  (make-package "OBJECT_MSGS::REGISTEROBJECTREQUEST"))
(unless (find-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE")
  (make-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE"))

(in-package "ROS")





(defclass object_msgs::RegisterObjectRequest
  :super ros::object
  :slots (_name ))

(defmethod object_msgs::RegisterObjectRequest
  (:init
   (&key
    ((:name __name) "")
    )
   (send-super :init)
   (setq _name (string __name))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(intern "*SUCCESS*" (find-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE"))
(shadow '*SUCCESS* (find-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE"))
(defconstant object_msgs::RegisterObjectResponse::*SUCCESS* 0)
(intern "*EXISTS*" (find-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE"))
(shadow '*EXISTS* (find-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE"))
(defconstant object_msgs::RegisterObjectResponse::*EXISTS* 1)
(intern "*ERROR_INFO*" (find-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE"))
(shadow '*ERROR_INFO* (find-package "OBJECT_MSGS::REGISTEROBJECTRESPONSE"))
(defconstant object_msgs::RegisterObjectResponse::*ERROR_INFO* 2)

(defun object_msgs::RegisterObjectResponse-to-symbol (const)
  (cond
        ((= const 0) 'object_msgs::RegisterObjectResponse::*SUCCESS*)
        ((= const 1) 'object_msgs::RegisterObjectResponse::*EXISTS*)
        ((= const 2) 'object_msgs::RegisterObjectResponse::*ERROR_INFO*)
        (t nil)))

(defclass object_msgs::RegisterObjectResponse
  :super ros::object
  :slots (_success ))

(defmethod object_msgs::RegisterObjectResponse
  (:init
   (&key
    ((:success __success) 0)
    )
   (send-super :init)
   (setq _success (round __success))
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; byte _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; byte _success
       (write-byte _success s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; byte _success
     (setq _success (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _success 127) (setq _success (- _success 256)))
   ;;
   self)
  )

(defclass object_msgs::RegisterObject
  :super ros::object
  :slots ())

(setf (get object_msgs::RegisterObject :md5sum-) "325b0c2df13037cc771f5f0cd7f14976")
(setf (get object_msgs::RegisterObject :datatype-) "object_msgs/RegisterObject")
(setf (get object_msgs::RegisterObject :request) object_msgs::RegisterObjectRequest)
(setf (get object_msgs::RegisterObject :response) object_msgs::RegisterObjectResponse)

(defmethod object_msgs::RegisterObjectRequest
  (:response () (instance object_msgs::RegisterObjectResponse :init)))

(setf (get object_msgs::RegisterObjectRequest :md5sum-) "325b0c2df13037cc771f5f0cd7f14976")
(setf (get object_msgs::RegisterObjectRequest :datatype-) "object_msgs/RegisterObjectRequest")
(setf (get object_msgs::RegisterObjectRequest :definition-)
      "# object name to be registered
string name

---

# succes flag
byte success

# successfully registered
byte SUCCESS=0

# object already registered
byte EXISTS=1

# could not query required information for this object
byte ERROR_INFO=2

")

(setf (get object_msgs::RegisterObjectResponse :md5sum-) "325b0c2df13037cc771f5f0cd7f14976")
(setf (get object_msgs::RegisterObjectResponse :datatype-) "object_msgs/RegisterObjectResponse")
(setf (get object_msgs::RegisterObjectResponse :definition-)
      "# object name to be registered
string name

---

# succes flag
byte success

# successfully registered
byte SUCCESS=0

# object already registered
byte EXISTS=1

# could not query required information for this object
byte ERROR_INFO=2

")



(provide :object_msgs/RegisterObject "325b0c2df13037cc771f5f0cd7f14976")


