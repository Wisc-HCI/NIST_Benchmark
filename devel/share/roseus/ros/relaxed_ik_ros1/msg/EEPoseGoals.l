;; Auto-generated. Do not edit!


(when (boundp 'relaxed_ik_ros1::EEPoseGoals)
  (if (not (find-package "RELAXED_IK_ROS1"))
    (make-package "RELAXED_IK_ROS1"))
  (shadow 'EEPoseGoals (find-package "RELAXED_IK_ROS1")))
(unless (find-package "RELAXED_IK_ROS1::EEPOSEGOALS")
  (make-package "RELAXED_IK_ROS1::EEPOSEGOALS"))

(in-package "ROS")
;;//! \htmlinclude EEPoseGoals.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass relaxed_ik_ros1::EEPoseGoals
  :super ros::object
  :slots (_header _ee_poses _tolerances ))

(defmethod relaxed_ik_ros1::EEPoseGoals
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:ee_poses __ee_poses) ())
    ((:tolerances __tolerances) ())
    )
   (send-super :init)
   (setq _header __header)
   (setq _ee_poses __ee_poses)
   (setq _tolerances __tolerances)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
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
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Pose[] _ee_poses
    (apply #'+ (send-all _ee_poses :serialization-length)) 4
    ;; geometry_msgs/Twist[] _tolerances
    (apply #'+ (send-all _tolerances :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
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
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
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

(setf (get relaxed_ik_ros1::EEPoseGoals :md5sum-) "53bcbdf6cd22e9cc87da1de741a651ce")
(setf (get relaxed_ik_ros1::EEPoseGoals :datatype-) "relaxed_ik_ros1/EEPoseGoals")
(setf (get relaxed_ik_ros1::EEPoseGoals :definition-)
      "std_msgs/Header header
geometry_msgs/Pose[] ee_poses
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
float64 z
")



(provide :relaxed_ik_ros1/EEPoseGoals "53bcbdf6cd22e9cc87da1de741a651ce")


