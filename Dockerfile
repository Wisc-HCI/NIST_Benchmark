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
    ros-noetic-rgbd-launch


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


# Install Azure Kinect SDK dependencies
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/18.04/prod bionic main" > /etc/apt/sources.list.d/microsoft-prod.list && \
    apt-get update && \
    ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get install -y k4a-tools libk4a1.4 libk4a1.4-dev


# Install rosdep updates
COPY . /workspace
WORKDIR /workspace/
#RUN rosdep init 
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src --rosdistro noetic  -y --skip-keys="libfranka K4A ros-noetic-rgbd-launch"


# Set libfranka library

# RUN mkdir -p /workspace/libfranka/build
# WORKDIR /workspace/libfranka/build
# RUN cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF ..
# RUN cmake --build .
# RUN cpack -G DEB
RUN  dpkg -i /workspace/libfranka/build/libfranka-0.9.2-x86_64.deb  
#RUN  dpkg -i libfranka-0.9.2-x86_64.deb  


WORKDIR /workspace/

# Set the default command to execute
# When creating a container, this will simulate `docker run -it`
CMD ["bash"]
