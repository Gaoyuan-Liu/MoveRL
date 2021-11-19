;; Auto-generated. Do not edit!


(when (boundp 'gazebo_test_tools::RecognizeGazeboObject)
  (if (not (find-package "GAZEBO_TEST_TOOLS"))
    (make-package "GAZEBO_TEST_TOOLS"))
  (shadow 'RecognizeGazeboObject (find-package "GAZEBO_TEST_TOOLS")))
(unless (find-package "GAZEBO_TEST_TOOLS::RECOGNIZEGAZEBOOBJECT")
  (make-package "GAZEBO_TEST_TOOLS::RECOGNIZEGAZEBOOBJECT"))
(unless (find-package "GAZEBO_TEST_TOOLS::RECOGNIZEGAZEBOOBJECTREQUEST")
  (make-package "GAZEBO_TEST_TOOLS::RECOGNIZEGAZEBOOBJECTREQUEST"))
(unless (find-package "GAZEBO_TEST_TOOLS::RECOGNIZEGAZEBOOBJECTRESPONSE")
  (make-package "GAZEBO_TEST_TOOLS::RECOGNIZEGAZEBOOBJECTRESPONSE"))

(in-package "ROS")





(defclass gazebo_test_tools::RecognizeGazeboObjectRequest
  :super ros::object
  :slots (_name _republish ))

(defmethod gazebo_test_tools::RecognizeGazeboObjectRequest
  (:init
   (&key
    ((:name __name) "")
    ((:republish __republish) nil)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _republish __republish)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:republish
   (&optional (__republish :null))
   (if (not (eq __republish :null)) (setq _republish __republish)) _republish)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; bool _republish
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _republish
       (if _republish (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _republish
     (setq _republish (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass gazebo_test_tools::RecognizeGazeboObjectResponse
  :super ros::object
  :slots (_success ))

(defmethod gazebo_test_tools::RecognizeGazeboObjectResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass gazebo_test_tools::RecognizeGazeboObject
  :super ros::object
  :slots ())

(setf (get gazebo_test_tools::RecognizeGazeboObject :md5sum-) "c151db741a1313b78299ced3566a6a06")
(setf (get gazebo_test_tools::RecognizeGazeboObject :datatype-) "gazebo_test_tools/RecognizeGazeboObject")
(setf (get gazebo_test_tools::RecognizeGazeboObject :request) gazebo_test_tools::RecognizeGazeboObjectRequest)
(setf (get gazebo_test_tools::RecognizeGazeboObject :response) gazebo_test_tools::RecognizeGazeboObjectResponse)

(defmethod gazebo_test_tools::RecognizeGazeboObjectRequest
  (:response () (instance gazebo_test_tools::RecognizeGazeboObjectResponse :init)))

(setf (get gazebo_test_tools::RecognizeGazeboObjectRequest :md5sum-) "c151db741a1313b78299ced3566a6a06")
(setf (get gazebo_test_tools::RecognizeGazeboObjectRequest :datatype-) "gazebo_test_tools/RecognizeGazeboObjectRequest")
(setf (get gazebo_test_tools::RecognizeGazeboObjectRequest :definition-)
      "# name of the object in Gazebo which is to be detected
# and published as object_msgs/Object.msg
string name

# If true, continuously re-publish the current
# state of the object (continuously \"re-recognize\").
# If false, and the object was previously set to
# republish, this will stop the re-publishing.
bool republish

---

# If true, found the object in Gazebo and published the message.
bool success

")

(setf (get gazebo_test_tools::RecognizeGazeboObjectResponse :md5sum-) "c151db741a1313b78299ced3566a6a06")
(setf (get gazebo_test_tools::RecognizeGazeboObjectResponse :datatype-) "gazebo_test_tools/RecognizeGazeboObjectResponse")
(setf (get gazebo_test_tools::RecognizeGazeboObjectResponse :definition-)
      "# name of the object in Gazebo which is to be detected
# and published as object_msgs/Object.msg
string name

# If true, continuously re-publish the current
# state of the object (continuously \"re-recognize\").
# If false, and the object was previously set to
# republish, this will stop the re-publishing.
bool republish

---

# If true, found the object in Gazebo and published the message.
bool success

")



(provide :gazebo_test_tools/RecognizeGazeboObject "c151db741a1313b78299ced3566a6a06")


