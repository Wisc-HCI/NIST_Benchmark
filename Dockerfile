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
    wget
    
RUN curl -sSL -O https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

RUN dpkg -i packages-microsoft-prod.deb

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

# Set CMAKE_PREFIX_PATH
ENV CMAKE_PREFIX_PATH="/usr/lib/x86_64-linux-gnu/cmake/k4a:$CMAKE_PREFIX_PATH"

# OR Set k4a_DIR directly if CMAKE_PREFIX_PATH doesn't work
# ENV k4a_DIR="/usr/lib/x86_64-linux-gnu/cmake/k4a"


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
RUN addgroup realtime
RUN usermod -a -G realtime $(whoami)
RUN echo "@realtime soft rtprio 99" | tee -a /etc/security/limits.conf
RUN echo "@realtime soft priority 99" | tee -a /etc/security/limits.conf
RUN echo "@realtime soft memlock 102400" | tee -a /etc/security/limits.conf
RUN echo "@realtime hard rtprio 99" | tee -a /etc/security/limits.conf
RUN echo "@realtime hard priority 99" | tee -a /etc/security/limits.conf
RUN echo "@realtime hard memlock 102400" | tee -a /etc/security/limits.conf


# Install rosdep updates
COPY . /workspace
WORKDIR /workspace/
#RUN rosdep init 
#RUN rosdep update
#RUN rosdep install --from-paths src --ignore-src --rosdistro noetic  -y --skip-keys K4A libfranka


# Set libfranka library

# RUN mkdir -p /workspace/libfranka/build
# WORKDIR /workspace/libfranka/build
# RUN cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF ..
# RUN cmake --build .
# RUN cpack -G DEB
RUN  dpkg -i /workspace/libfranka/build/libfranka-0.9.2-x86_64.deb  
#RUN  dpkg -i libfranka-0.9.2-x86_64.deb  

RUN rosdep update
RUN rosdep install --from-paths src --ignore-src --rosdistro noetic  -y --skip-keys K4A libfranka


WORKDIR /workspace/

# Set the default command to execute
# When creating a container, this will simulate `docker run -it`
CMD ["bash"]



