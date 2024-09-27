#include <ros/ros.h>
#include <sensor_msgs/JointState.h>
#include <geometry_msgs/Pose.h>

#include <relaxed_ik_ros1/IKPose.h>

int main(int argc, char** argv)
{
    // Initialize the ROS node
    ros::init(argc, argv, "publish_cartesian_position");
    ros::NodeHandle nh;

    // Create a publisher for the /equilibrium_configuration topic
    ros::Publisher pub = nh.advertise<sensor_msgs::JointState>("/equilibrium_configuration", 10);

    // Allow some time for the publisher to set up
    ros::Duration(0.5).sleep();
    
    // Prepare the IKPose request and response objects
    ros::ServiceClient ik_client = nh.serviceClient<relaxed_ik_ros1::IKPose>("relaxed_ik/solve_pose");
    ros::service::waitForService("relaxed_ik/solve_pose");


    // CHANGE THESE TO CHANGE POSITION
    geometry_msgs::Pose desired_pose;
    desired_pose.position.x = 0.5;
    desired_pose.position.y = 0.0;
    desired_pose.position.z = 0.5;
    desired_pose.orientation.x = 1;
    desired_pose.orientation.y = 0.0;
    desired_pose.orientation.z = 0.0;
    desired_pose.orientation.w = 0.0;

    relaxed_ik_ros1::IKPose srv;
    srv.request.ee_poses.push_back(desired_pose);

    if (ik_client.call(srv)) {
        
        // Create the JointState message
        sensor_msgs::JointState msg;
        msg.header.stamp = ros::Time::now();
        msg.position = srv.response.joint_state;

        // Publish the message
        pub.publish(msg);

        ROS_INFO_STREAM("Calculated Joint Configuration: " << srv.response); // IF PUT THIS BEFORE SENDING MESSAGE, IT WON'T BE SENT???
        ROS_INFO("Published equilibrium configuration to /equilibrium_configuration");

    } else {
        ROS_ERROR("Failed to call IK service or send Joint State message ");
    }

    // Optional: Spin once if you have callbacks (not necessary in this simple case)
    ros::spinOnce();

    return 0;
}
