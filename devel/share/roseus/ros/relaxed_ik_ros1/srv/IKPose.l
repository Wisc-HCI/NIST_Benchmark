;; Auto-generated. Do not edit!


(when (boundp 'relaxed_ik_ros1::IKPose)
  (if (not (find-package "RELAXED_IK_ROS1"))
    (make-package "RELAXED_IK_ROS1"))
  (shadow 'IKPose (find-package "RELAXED_IK_ROS1")))
(unless (find-package "RELAXED_IK_ROS1::IKPOSE")
  (make-package "RELAXED_IK_ROS1::IKPOSE"))
(unless (find-package "RELAXED_IK_ROS1::IKPOSEREQUEST")
  (make-package "RELAXED_IK_ROS1::IKPOSEREQUEST"))
(unless (find-package "RELAXED_IK_ROS1::IKPOSERESPONSE")
  (make-package "RELAXED_IK_ROS1::IKPOSERESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass relaxed_ik_ros1::IKPoseRequest
  :super ros::object
  :slots (_ee_poses _tolerances ))

(defmethod relaxed_ik_ros1::IKPoseRequest
  (:init
   (&key
    ((:ee_poses __ee_poses) ())
    ((:tolerances __tolerances) ())
    )
   (send-super :init)
   (setq _ee_poses __ee_poses)
   (setq _tolerances __tolerances)
   self)
  (:ee_poses
   (&rest __ee_poses)
   (if (keywordp (car __ee_poses))
       (send* _ee_poses __ee_poses)
     (progn
       (if __ee_poses (setq _ee_poses (car __ee_poses)))
       _ee_poses)))
  (:tolerances
   (&rest __tolerances)
   (if (keywordp (car __tolerances))
       (send* _tolerances __tolerances)
     (progn
       (if __tolerances (setq _tolerances (car __tolerances)))
       _tolerances)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose[] _ee_poses
    (apply #'+ (send-all _ee_poses :serialization-length)) 4
    ;; geometry_msgs/Twist[] _tolerances
    (apply #'+ (send-all _tolerances :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose[] _ee_poses
     (write-long (length _ee_poses) s)
     (dolist (elem _ee_poses)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Twist[] _tolerances
     (write-long (length _tolerances) s)
     (dolist (elem _tolerances)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose[] _ee_poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ee_poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Pose :init) r)) r))
     (dolist (elem- _ee_poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Twist[] _tolerances
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tolerances (let (r) (dotimes (i n) (push (instance geometry_msgs::Twist :init) r)) r))
     (dolist (elem- _tolerances)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass relaxed_ik_ros1::IKPoseResponse
  :super ros::object
  :slots (_joint_state ))

(defmethod relaxed_ik_ros1::IKPoseResponse
  (:init
   (&key
    ((:joint_state __joint_state) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _joint_state __joint_state)
   self)
  (:joint_state
   (&optional __joint_state)
   (if __joint_state (setq _joint_state __joint_state)) _joint_state)
  (:serialization-length
   ()
   (+
    ;; float64[] _joint_state
    (* 8    (length _joint_state)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _joint_state
     (write-long (length _joint_state) s)
     (dotimes (i (length _joint_state))
       (sys::poke (elt _joint_state i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _joint_state
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _joint_state (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _joint_state i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;;
   self)
  )

(defclass relaxed_ik_ros1::IKPose
  :super ros::object
  :slots ())

(setf (get relaxed_ik_ros1::IKPose :md5sum-) "87c66b5bf696f783971b87b3f0518ef4")
(setf (get relaxed_ik_ros1::IKPose :datatype-) "relaxed_ik_ros1/IKPose")
(setf (get relaxed_ik_ros1::IKPose :request) relaxed_ik_ros1::IKPoseRequest)
(setf (get relaxed_ik_ros1::IKPose :response) relaxed_ik_ros1::IKPoseResponse)

(defmethod relaxed_ik_ros1::IKPoseRequest
  (:response () (instance relaxed_ik_ros1::IKPoseResponse :init)))

(setf (get relaxed_ik_ros1::IKPoseRequest :md5sum-) "87c66b5bf696f783971b87b3f0518ef4")
(setf (get relaxed_ik_ros1::IKPoseRequest :datatype-) "relaxed_ik_ros1/IKPoseRequest")
(setf (get relaxed_ik_ros1::IKPoseRequest :definition-)
      "geometry_msgs/Pose[] ee_poses
geometry_msgs/Twist[] tolerances

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
---
float64[] joint_state
")

(setf (get relaxed_ik_ros1::IKPoseResponse :md5sum-) "87c66b5bf696f783971b87b3f0518ef4")
(setf (get relaxed_ik_ros1::IKPoseResponse :datatype-) "relaxed_ik_ros1/IKPoseResponse")
(setf (get relaxed_ik_ros1::IKPoseResponse :definition-)
      "geometry_msgs/Pose[] ee_poses
geometry_msgs/Twist[] tolerances

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
---
float64[] joint_state
")



(provide :relaxed_ik_ros1/IKPose "87c66b5bf696f783971b87b3f0518ef4")


