;; Auto-generated. Do not edit!


(when (boundp 'rl_interface::PandaCmd)
  (if (not (find-package "RL_INTERFACE"))
    (make-package "RL_INTERFACE"))
  (shadow 'PandaCmd (find-package "RL_INTERFACE")))
(unless (find-package "RL_INTERFACE::PANDACMD")
  (make-package "RL_INTERFACE::PANDACMD"))
(unless (find-package "RL_INTERFACE::PANDACMDREQUEST")
  (make-package "RL_INTERFACE::PANDACMDREQUEST"))
(unless (find-package "RL_INTERFACE::PANDACMDRESPONSE")
  (make-package "RL_INTERFACE::PANDACMDRESPONSE"))

(in-package "ROS")

(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass rl_interface::PandaCmdRequest
  :super ros::object
  :slots (_cmd ))

(defmethod rl_interface::PandaCmdRequest
  (:init
   (&key
    ((:cmd __cmd) (instance std_msgs::Float64MultiArray :init))
    )
   (send-super :init)
   (setq _cmd __cmd)
   self)
  (:cmd
   (&rest __cmd)
   (if (keywordp (car __cmd))
       (send* _cmd __cmd)
     (progn
       (if __cmd (setq _cmd (car __cmd)))
       _cmd)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Float64MultiArray _cmd
    (send _cmd :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Float64MultiArray _cmd
       (send _cmd :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Float64MultiArray _cmd
     (send _cmd :deserialize buf ptr-) (incf ptr- (send _cmd :serialization-length))
   ;;
   self)
  )

(defclass rl_interface::PandaCmdResponse
  :super ros::object
  :slots (_success ))

(defmethod rl_interface::PandaCmdResponse
  (:init
   (&key
    ((:success __success) (instance std_msgs::Bool :init))
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&rest __success)
   (if (keywordp (car __success))
       (send* _success __success)
     (progn
       (if __success (setq _success (car __success)))
       _success)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Bool _success
    (send _success :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Bool _success
       (send _success :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Bool _success
     (send _success :deserialize buf ptr-) (incf ptr- (send _success :serialization-length))
   ;;
   self)
  )

(defclass rl_interface::PandaCmd
  :super ros::object
  :slots ())

(setf (get rl_interface::PandaCmd :md5sum-) "c1a7b32be5be6c0f024512355d194266")
(setf (get rl_interface::PandaCmd :datatype-) "rl_interface/PandaCmd")
(setf (get rl_interface::PandaCmd :request) rl_interface::PandaCmdRequest)
(setf (get rl_interface::PandaCmd :response) rl_interface::PandaCmdResponse)

(defmethod rl_interface::PandaCmdRequest
  (:response () (instance rl_interface::PandaCmdResponse :init)))

(setf (get rl_interface::PandaCmdRequest :md5sum-) "c1a7b32be5be6c0f024512355d194266")
(setf (get rl_interface::PandaCmdRequest :datatype-) "rl_interface/PandaCmdRequest")
(setf (get rl_interface::PandaCmdRequest :definition-)
      "std_msgs/Float64MultiArray cmd

================================================================================
MSG: std_msgs/Float64MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
float64[]         data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
---
std_msgs/Bool success

================================================================================
MSG: std_msgs/Bool
")

(setf (get rl_interface::PandaCmdResponse :md5sum-) "c1a7b32be5be6c0f024512355d194266")
(setf (get rl_interface::PandaCmdResponse :datatype-) "rl_interface/PandaCmdResponse")
(setf (get rl_interface::PandaCmdResponse :definition-)
      "std_msgs/Float64MultiArray cmd

================================================================================
MSG: std_msgs/Float64MultiArray
# Please look at the MultiArrayLayout message definition for
# documentation on all multiarrays.

MultiArrayLayout  layout        # specification of data layout
float64[]         data          # array of data


================================================================================
MSG: std_msgs/MultiArrayLayout
# The multiarray declares a generic multi-dimensional array of a
# particular data type.  Dimensions are ordered from outer most
# to inner most.

MultiArrayDimension[] dim # Array of dimension properties
uint32 data_offset        # padding elements at front of data

# Accessors should ALWAYS be written in terms of dimension stride
# and specified outer-most dimension first.
# 
# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]
#
# A standard, 3-channel 640x480 image with interleaved color channels
# would be specified as:
#
# dim[0].label  = \"height\"
# dim[0].size   = 480
# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)
# dim[1].label  = \"width\"
# dim[1].size   = 640
# dim[1].stride = 3*640 = 1920
# dim[2].label  = \"channel\"
# dim[2].size   = 3
# dim[2].stride = 3
#
# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.

================================================================================
MSG: std_msgs/MultiArrayDimension
string label   # label of given dimension
uint32 size    # size of given dimension (in type units)
---
std_msgs/Bool success

================================================================================
MSG: std_msgs/Bool
")



(provide :rl_interface/PandaCmd "c1a7b32be5be6c0f024512355d194266")


