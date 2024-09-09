;; Auto-generated. Do not edit!


(when (boundp 'relaxed_ik_ros1::EEVelGoals)
  (if (not (find-package "RELAXED_IK_ROS1"))
    (make-package "RELAXED_IK_ROS1"))
  (shadow 'EEVelGoals (find-package "RELAXED_IK_ROS1")))
(unless (find-package "RELAXED_IK_ROS1::EEVELGOALS")
  (make-package "RELAXED_IK_ROS1::EEVELGOALS"))

(in-package "ROS")
;;//! \htmlinclude EEVelGoals.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass relaxed_ik_ros1::EEVelGoals
  :super ros::object
  :slots (_header _ee_vels _tolerances ))

(defmethod relaxed_ik_ros1::EEVelGoals
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:ee_vels __ee_vels) ())
    ((:tolerances __tolerances) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _ee_vels __ee_vels)
   (setq _tolerances __tolerances)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
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
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Twist[] _ee_vels
    (apply #'+ (send-all _ee_vels :serialization-length)) 4
    ;; geometry_msgs/Twist[] _tolerances
    (apply #'+ (send-all _tolerances :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
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
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
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

(setf (get relaxed_ik_ros1::EEVelGoals :md5sum-) "73a8278b72bc91801a6231533cba27f3")
(setf (get relaxed_ik_ros1::EEVelGoals :datatype-) "relaxed_ik_ros1/EEVelGoals")
(setf (get relaxed_ik_ros1::EEVelGoals :definition-)
      "std_msgs/Header header
geometry_msgs/Twist[] ee_vels
geometry_msgs/Twist[] tolerances

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
float64 z
")



(provide :relaxed_ik_ros1/EEVelGoals "73a8278b72bc91801a6231533cba27f3")


