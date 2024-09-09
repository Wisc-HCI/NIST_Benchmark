
(cl:in-package :asdf)

(defsystem "relaxed_ik_ros1-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "EEPoseGoals" :depends-on ("_package_EEPoseGoals"))
    (:file "_package_EEPoseGoals" :depends-on ("_package"))
    (:file "EEVelGoals" :depends-on ("_package_EEVelGoals"))
    (:file "_package_EEVelGoals" :depends-on ("_package"))
  ))