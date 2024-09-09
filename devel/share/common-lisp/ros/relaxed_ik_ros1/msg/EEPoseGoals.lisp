; Auto-generated. Do not edit!


(cl:in-package relaxed_ik_ros1-msg)


;//! \htmlinclude EEPoseGoals.msg.html

(cl:defclass <EEPoseGoals> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (ee_poses
    :reader ee_poses
    :initarg :ee_poses
    :type (cl:vector geometry_msgs-msg:Pose)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Pose :initial-element (cl:make-instance 'geometry_msgs-msg:Pose)))
   (tolerances
    :reader tolerances
    :initarg :tolerances
    :type (cl:vector geometry_msgs-msg:Twist)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Twist :initial-element (cl:make-instance 'geometry_msgs-msg:Twist))))
)

(cl:defclass EEPoseGoals (<EEPoseGoals>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EEPoseGoals>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EEPoseGoals)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name relaxed_ik_ros1-msg:<EEPoseGoals> is deprecated: use relaxed_ik_ros1-msg:EEPoseGoals instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EEPoseGoals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-msg:header-val is deprecated.  Use relaxed_ik_ros1-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'ee_poses-val :lambda-list '(m))
(cl:defmethod ee_poses-val ((m <EEPoseGoals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-msg:ee_poses-val is deprecated.  Use relaxed_ik_ros1-msg:ee_poses instead.")
  (ee_poses m))

(cl:ensure-generic-function 'tolerances-val :lambda-list '(m))
(cl:defmethod tolerances-val ((m <EEPoseGoals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader relaxed_ik_ros1-msg:tolerances-val is deprecated.  Use relaxed_ik_ros1-msg:tolerances instead.")
  (tolerances m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EEPoseGoals>) ostream)
  "Serializes a message object of type '<EEPoseGoals>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ee_poses))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'ee_poses))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'tolerances))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'tolerances))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EEPoseGoals>) istream)
  "Deserializes a message object of type '<EEPoseGoals>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ee_poses) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ee_poses)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Pose))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'tolerances) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'tolerances)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Twist))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EEPoseGoals>)))
  "Returns string type for a message object of type '<EEPoseGoals>"
  "relaxed_ik_ros1/EEPoseGoals")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EEPoseGoals)))
  "Returns string type for a message object of type 'EEPoseGoals"
  "relaxed_ik_ros1/EEPoseGoals")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EEPoseGoals>)))
  "Returns md5sum for a message object of type '<EEPoseGoals>"
  "53bcbdf6cd22e9cc87da1de741a651ce")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EEPoseGoals)))
  "Returns md5sum for a message object of type 'EEPoseGoals"
  "53bcbdf6cd22e9cc87da1de741a651ce")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EEPoseGoals>)))
  "Returns full string definition for message of type '<EEPoseGoals>"
  (cl:format cl:nil "std_msgs/Header header~%geometry_msgs/Pose[] ee_poses~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EEPoseGoals)))
  "Returns full string definition for message of type 'EEPoseGoals"
  (cl:format cl:nil "std_msgs/Header header~%geometry_msgs/Pose[] ee_poses~%geometry_msgs/Twist[] tolerances~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EEPoseGoals>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ee_poses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'tolerances) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EEPoseGoals>))
  "Converts a ROS message object to a list"
  (cl:list 'EEPoseGoals
    (cl:cons ':header (header msg))
    (cl:cons ':ee_poses (ee_poses msg))
    (cl:cons ':tolerances (tolerances msg))
))
