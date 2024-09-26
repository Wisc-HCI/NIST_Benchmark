#include <ros/ros.h>
#include <sensor_msgs/JointState.h>

#include <geometry_msgs/Pose.h>
#include <relaxed_ik_ros1/IKPose.h>
#include <relaxed_ik_ros1/IKPoseRequest.h>
#include <relaxed_ik_ros1/IKPoseResponse.h>

int main(int argc, char **argv) {
    ros::init(argc, argv, "joint_state_publisher");
    ros::NodeHandle n;
    ros::Publisher joint_pub = n.advertise<sensor_msgs::JointState>("equilibrium_configuration", 10);
    ros::Rate loop_rate(10);

    geometry_msgs::Pose desired_pose;
    desired_pose.position.x = 0.2;
    desired_pose.position.y = 0.0;
    desired_pose.position.z = 0.2;
    desired_pose.orientation.x = 1;
    desired_pose.orientation.y = 0.0;
    desired_pose.orientation.z = 0.0;
    desired_pose.orientation.w = 0.0;

    // Prepare the IKPose request and response objects
    ros::ServiceClient ik_client = n.serviceClient<relaxed_ik_ros1::IKPose>("relaxed_ik/solve_pose");
    ros::service::waitForService("relaxed_ik/solve_pose");

    relaxed_ik_ros1::IKPose srv;
    srv.request.ee_poses.push_back(desired_pose);

    // Call the service and process the response
    if (ik_client.call(srv)) {
        
        ROS_INFO_STREAM("Calculated Joint Configuration:" << srv.response);

        sensor_msgs::JointState msg;
        msg.position = {0.1, -0.785, 0, -2.356, 0, 1.57, 3.14}; //srv.response.joint_state;
        // msg.header.stamp = ros::Time::now();
        
        ROS_INFO_STREAM(msg);
        joint_pub.publish(msg);
    }
    else ROS_ERROR("Failed to call IK service or send Joint State message ");

    ros::spinOnce();
    loop_rate.sleep();

    return 0;
}
