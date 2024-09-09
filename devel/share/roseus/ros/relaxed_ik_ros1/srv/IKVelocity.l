;; Auto-generated. Do not edit!


(when (boundp 'relaxed_ik_ros1::IKVelocity)
  (if (not (find-package "RELAXED_IK_ROS1"))
    (make-package "RELAXED_IK_ROS1"))
  (shadow 'IKVelocity (find-package "RELAXED_IK_ROS1")))
(unless (find-package "RELAXED_IK_ROS1::IKVELOCITY")
  (make-package "RELAXED_IK_ROS1::IKVELOCITY"))
(unless (find-package "RELAXED_IK_ROS1::IKVELOCITYREQUEST")
  (make-package "RELAXED_IK_ROS1::IKVELOCITYREQUEST"))
(unless (find-package "RELAXED_IK_ROS1::IKVELOCITYRESPONSE")
  (make-package "RELAXED_IK_ROS1::IKVELOCITYRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))




(defclass relaxed_ik_ros1::IKVelocityRequest
  :super ros::object
  :slots (_ee_vels _tolerances ))

(defmethod relaxed_ik_ros1::IKVelocityRequest
  (:init
   (&key
    ((:ee_vels __ee_vels) ())
    ((:tolerances __tolerances) ())
    )
   (send-super :init)
   (setq _ee_vels __ee_vels)
   (setq _tolerances __tolerances)
   self)
  (:ee_vels
   (&rest __ee_vels)
   (if (keywordp (car __ee_vels))
       (send* _ee_vels __ee_vels)
     (progn
       (if __ee_vels (setq _ee_vels (car __ee_vels)))
       _ee_vels)))
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
    ;; geometry_msgs/Twist[] _ee_vels
    (apply #'+ (send-all _ee_vels :serialization-length)) 4
    ;; geometry_msgs/Twist[] _tolerances
    (apply #'+ (send-all _tolerances :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Twist[] _ee_vels
     (write-long (length _ee_vels) s)
     (dolist (elem _ee_vels)
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
   ;; geometry_msgs/Twist[] _ee_vels
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ee_vels (let (r) (dotimes (i n) (push (instance geometry_msgs::Twist :init) r)) r))
     (dolist (elem- _ee_vels)
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

(defclass relaxed_ik_ros1::IKVelocityResponse
  :super ros::object
  :slots (_joint_state ))

(defmethod relaxed_ik_ros1::IKVelocityResponse
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

(defclass relaxed_ik_ros1::IKVelocity
  :super ros::object
  :slots ())

(setf (get relaxed_ik_ros1::IKVelocity :md5sum-) "1cf8f3ae381e7b061b1fe16f359a61d2")
(setf (get relaxed_ik_ros1::IKVelocity :datatype-) "relaxed_ik_ros1/IKVelocity")
(setf (get relaxed_ik_ros1::IKVelocity :request) relaxed_ik_ros1::IKVelocityRequest)
(setf (get relaxed_ik_ros1::IKVelocity :response) relaxed_ik_ros1::IKVelocityResponse)

(defmethod relaxed_ik_ros1::IKVelocityRequest
  (:response () (instance relaxed_ik_ros1::IKVelocityResponse :init)))

(setf (get relaxed_ik_ros1::IKVelocityRequest :md5sum-) "1cf8f3ae381e7b061b1fe16f359a61d2")
(setf (get relaxed_ik_ros1::IKVelocityRequest :datatype-) "relaxed_ik_ros1/IKVelocityRequest")
(setf (get relaxed_ik_ros1::IKVelocityRequest :definition-)
      "geometry_msgs/Twist[] ee_vels
geometry_msgs/Twist[] tolerances

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

(setf (get relaxed_ik_ros1::IKVelocityResponse :md5sum-) "1cf8f3ae381e7b061b1fe16f359a61d2")
(setf (get relaxed_ik_ros1::IKVelocityResponse :datatype-) "relaxed_ik_ros1/IKVelocityResponse")
(setf (get relaxed_ik_ros1::IKVelocityResponse :definition-)
      "geometry_msgs/Twist[] ee_vels
geometry_msgs/Twist[] tolerances

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



(provide :relaxed_ik_ros1/IKVelocity "1cf8f3ae381e7b061b1fe16f359a61d2")


