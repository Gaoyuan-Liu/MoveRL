;; Auto-generated. Do not edit!


(when (boundp 'panda_state::RobotStates)
  (if (not (find-package "PANDA_STATE"))
    (make-package "PANDA_STATE"))
  (shadow 'RobotStates (find-package "PANDA_STATE")))
(unless (find-package "PANDA_STATE::ROBOTSTATES")
  (make-package "PANDA_STATE::ROBOTSTATES"))

(in-package "ROS")
;;//! \htmlinclude RobotStates.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass panda_state::RobotStates
  :super ros::object
  :slots (_header _xe ))

(defmethod panda_state::RobotStates
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:xe __xe) (let (r) (dotimes (i 3) (push (instance std_msgs::Float64 :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _xe __xe)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:xe
   (&rest __xe)
   (if (keywordp (car __xe))
       (send* _xe __xe)
     (progn
       (if __xe (setq _xe (car __xe)))
       _xe)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; std_msgs/Float64[3] _xe
    (apply #'+ (send-all _xe :serialization-length))
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; std_msgs/Float64[3] _xe
     (dolist (elem _xe)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; std_msgs/Float64[3] _xe
   (dotimes (i 3)
     (send (elt _xe i) :deserialize buf ptr-) (incf ptr- (send (elt _xe i) :serialization-length))
     )
   ;;
   self)
  )

(setf (get panda_state::RobotStates :md5sum-) "79c455d062acdbc2bbc3010df721a4d4")
(setf (get panda_state::RobotStates :datatype-) "panda_state/RobotStates")
(setf (get panda_state::RobotStates :definition-)
      "Header header

std_msgs/Float64[3] xe 
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: std_msgs/Float64
float64 data
")



(provide :panda_state/RobotStates "79c455d062acdbc2bbc3010df721a4d4")


