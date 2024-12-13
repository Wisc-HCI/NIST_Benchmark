# Use an official Ubuntu 20.04 LTS as a parent image
FROM osrf/ros:noetic-desktop-full

# Set noninteractive to avoid prompts during the build
ARG DEBIAN_FRONTEND=noninteractive

# Update apt package list and install general packages
RUN apt-get update && \
    apt-get install -y --fix-missing \
    curl\
    python3-pip\
    build-essential\ 
    cmake\
    libpoco-dev\ 
    libeigen3-dev\
    python3-rosdep\
    mesa-utils\
    nano\
    python3-catkin-tools\ 
    ros-noetic-gazebo-ros-control\
    ros-noetic-rospy-message-converter\
    ros-noetic-effort-controllers\
    ros-noetic-joint-state-controller\
    ros-noetic-moveit\
    ros-noetic-moveit-commander\
    ros-noetic-moveit-visual-tools\
    # wget\
    curl
    # software-properties-common\
    # ros-noetic-ros-control\
    # ros-noetic-ros-controllers\
    # ros-noetic-combined-robot-hw\
    # libboost-all-dev

# Download boost_sml and install in /usr/local/include for CMake to find it
# RUN mkdir -p /usr/local/include/boost && \
#     wget https://raw.githubusercontent.com/boost-ext/sml/master/include/boost/sml.hpp -O /usr/local/include/boost/sml.hpp

# # Add Microsoft's package signing key and repository for Ubuntu 18.04
# RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
#     apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod && \
#     apt-get update

# # Add Microsoft's package signing key
# RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# # Add Microsoft repository for Ubuntu 18.04 manually and update
# RUN echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/18.04/prod bionic main" > /etc/apt/sources.list.d/microsoft-prod.list && \
#     apt-get update

# # Install Azure Kinect SDK dependencies
# RUN apt-get install -y k4a-tools libk4a1.4 libk4a1.4-dev

# Preconfigure EULA acceptance
# RUN echo "libk4a1.4 libk4a1.4/accepted-eula select true" | debconf-set-selections

# Install Azure Kinect SDK dependencies
# RUN ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get install -y k4a-tools libk4a1.4 libk4a1.4-dev

# # Install Azure Kinect SDK dependencies
# RUN apt-get update --fix-missing && apt-get install -y \
#     software-properties-common \
#     lsb-release && \
#     add-apt-repository ppa:mbakke/k4a && \
#     apt-get update && \
#     apt-get install -y \
#     k4a-tools \
#     libk4a1.4-dev \
#     libk4abt1.0-dev

# # Download and install Azure Kinect SDK from Microsoft's GitHub
# RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb && \
#     dpkg -i packages-microsoft-prod.deb && \
#     apt-get update && \
#     apt-get install -y k4a-tools libk4a1.4-dev libk4abt1.0-dev && \
#     rm packages-microsoft-prod.deb

# # Download and install Azure Kinect Sensor SDK
# RUN wget https://github.com/microsoft/Azure-Kinect-Sensor-SDK/releases/download/v1.4.1/libk4a1.4_1.4.1_amd64.deb && \
#     wget https://github.com/microsoft/Azure-Kinect-Sensor-SDK/releases/download/v1.4.1/libk4a1.4-dev_1.4.1_amd64.deb && \
#     dpkg -i libk4a1.4_1.4.1_amd64.deb libk4a1.4-dev_1.4.1_amd64.deb && \
#     rm libk4a1.4_1.4.1_amd64.deb libk4a1.4-dev_1.4.1_amd64.deb

# # Download and install Azure Kinect SDK
# RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
#     dpkg -i packages-microsoft-prod.deb && \
#     apt-get update && \
#     apt-get install -y k4a-tools libk4a1.4 libk4a1.4-dev

# # Download and install Azure Kinect SDK manually
# RUN apt-get update && \
#     apt-get install -y wget unzip && \
#     wget https://github.com/microsoft/Azure-Kinect-Sensor-SDK/releases/download/v1.4.1/k4a-linux-native-1.4.1.zip -O k4a.zip && \
#     unzip k4a.zip -d k4a && \
#     dpkg -i k4a/packages/libk4a1.4_1.4.2_amd64.deb && \
#     dpkg -i k4a/packages/libk4a1.4-dev_1.4.2_amd64.deb && \
#     dpkg -i k4a/packages/k4a-tools_1.4.2_amd64.deb && \
#     rm -rf k4a.zip k4a
    
#RUN curl -sSL -O https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

#RUN dpkg -i packages-microsoft-prod.deb

# Download these two .deb files: 
# RUN wget https://packages.microsoft.com/ubuntu/18.04/prod/pool/main/libk/libk4a1.4-dev/libk4a1.4-dev_1.4.1_amd64.deb
# RUN wget https://packages.microsoft.com/ubuntu/18.04/prod/pool/main/libk/libk4a1.4/libk4a1.4_1.4.1_amd64.deb

# Install them:
# RUN dpkg -i ./*.deb

#RUN apt-get update && \
#    apt-get install -y --fix-missing \
#    libk4a1.4\
#    libk4a1.4-dev\
#    k4a-tools

# # Build Azure-Kinect-Sensor-SDK
# RUN cd /workspace/Azure-Kinect-Sensor-SDK && \
#     mkdir build && cd build && \
#     cmake .. && make && make install

# # Build Azure_Kinect_ROS_Driver
# RUN source /opt/ros/noetic/setup.bash && \
#     cd /workspace/Azure_Kinect_ROS_Driver && \
#     catkin_make

# Add k4a to CMAKE_PREFIX_PATH
# ENV CMAKE_PREFIX_PATH="/usr/lib/x86_64-linux-gnu/cmake/k4a:${CMAKE_PREFIX_PATH}"

# ENV CMAKE_PREFIX_PATH=/opt/ros/noetic:/workspace/devel:$CMAKE_PREFIX_PATH

# OR Set k4a_DIR directly if CMAKE_PREFIX_PATH doesn't work
# ENV k4a_DIR="/usr/lib/x86_64-linux-gnu/cmake/k4a"

# Set up library paths and ROS workspace
# ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
# ENV ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/workspace/Azure_Kinect_ROS_Driver


# Install python packages
RUN pip install future\
    PyYaml\
    urdf-parser-py\
    panda_robot\
    numpy==1.21


# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Set up realtime configs (for realtime kernel)
# RUN addgroup realtime
# RUN usermod -a -G realtime $(whoami)
# RUN echo "@realtime soft rtprio 99" | tee -a /etc/security/limits.conf
# RUN echo "@realtime soft priority 99" | tee -a /etc/security/limits.conf
# RUN echo "@realtime soft memlock 102400" | tee -a /etc/security/limits.conf
# RUN echo "@realtime hard rtprio 99" | tee -a /etc/security/limits.conf
# RUN echo "@realtime hard priority 99" | tee -a /etc/security/limits.conf
# RUN echo "@realtime hard memlock 102400" | tee -a /etc/security/limits.conf

# Install Azure Kinect SDK dependencies
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/18.04/prod bionic main" > /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && \
    ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get install -y k4a-tools libk4a1.4 libk4a1.4-dev

RUN apt-get update && apt-get install -y alsa-utils

# Install rosdep updates
COPY . /workspace
WORKDIR /workspace/
# RUN rosdep init 
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src --rosdistro noetic  -y --skip-keys="libfranka K4A"

# Clean up devel folder to avoid duplicate packages
# RUN rm -rf /workspace/devel

# Run catkin_make clean to reset build state
# RUN cd /workspace && catkin_make clean

# Retry rosdep install
# RUN rosdep install --from-paths src --ignore-src --rosdistro noetic -y --skip-keys K4A libfranka


# Set libfranka library

# RUN mkdir -p /workspace/libfranka/build
# WORKDIR /workspace/libfranka/build
# RUN cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF ..
# RUN cmake --build .
# RUN cpack -G DEB
RUN  dpkg -i /workspace/libfranka/build/libfranka-0.9.2-x86_64.deb  
# RUN  dpkg -i libfranka-0.9.2-x86_64.deb  

RUN rosdep update
# RUN rosdep install --from-paths src --ignore-src --rosdistro noetic  -y --skip-keys K4A
# RUN rosdep install --from-paths src --ignore-src --rosdistro noetic  -y --skip-keys libfranka

# # Build the Azure-Kinect-Sensor-SDK
# RUN cd Azure-Kinect-Sensor-SDK && \
#     mkdir build && cd build && \
#     cmake .. && \
#     make -j$(nproc) && \
#     make install

# # Set up Azure Kinect ROS Driver dependencies
# RUN rosdep update && \
#     rosdep install --from-paths /workspace --ignore-src -r -y

WORKDIR /workspace/

# Set the default command to execute
# When creating a container, this will simulate `docker run -it`
CMD ["bash"]



