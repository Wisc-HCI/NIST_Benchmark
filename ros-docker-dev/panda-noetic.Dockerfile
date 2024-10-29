
FROM osrf/ros:noetic-desktop-full

######################################################################
### ARG and ENV Passing ##############################################
######################################################################
ARG USERNAME=panda
ARG USER_ID=1000
ARG GROUP_ID=1000

ENV TZ=America/Chicago
ENV DISPLAY=":0"
### End ##############################################################
######################################################################



######################################################################
### Ubuntu Essentials ################################################
######################################################################
# Development Tools
RUN apt update && apt install --yes \
    build-essential gcc g++ gdb cmake \
    clang-12 clang-format-12 \
    software-properties-common \
    nano vim \
    valgrind \
    git

# Productivity Tools.
RUN apt update && apt install --yes \
    iproute2 iputils-ping net-tools openssh-client\
    curl wget \
    unzip zip \
    usbutils mesa-utils \
    tmux \
    zsh

# Python Tools
RUN apt-get update && apt-get install --yes \
    python-is-python3 \
    python3-catkin-tools \
    python3-pip
RUN pip3 install --upgrade virtualenv
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install --yes \
    python3.9 python3.9-dev python3.9-distutils python3.9-venv \
    python3.10 python3.10-dev python3.10-distutils python3.10-venv
### End ##############################################################
######################################################################



######################################################################
### User Spoofing ####################################################
######################################################################
# Create User and Group with passed ARG in .hcl file
RUN groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} \
        --create-home \
        --shell /bin/bash \
        ${USERNAME}

# Setup HOME dir
ENV HOME=/home/${USERNAME}
WORKDIR ${HOME}
### End ##############################################################
######################################################################



# Editable from now
######################################################################
### Git ##############################################################
######################################################################
USER ${USERNAME}
# SSH forward is only valid to root, so we should specify it owned by uid
RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
# It is better to volume current repo instead of clone an another one in container
# RUN --mount=type=ssh,uid=${USER_ID} \
#     git clone git@github.com:AlfredMoore/HANDREC_Panda.git --recursive
### End ##############################################################
######################################################################



######################################################################
### Panda ROS Dev ####################################################
######################################################################
# Install libfranka and franka-ros
USER root
RUN apt-get update && apt-get install --yes \
    ros-noetic-libfranka ros-noetic-franka-ros

# Install ranged-IK Python dependencies
RUN pip3 install \
    readchar \
    PyYaml \
    urdf-parser-py \
    future \
    pynput

# Install ranged-IK Rust and Cargo dependencies
## Switch to new user
USER ${USERNAME}
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/${USERNAME}/.cargo/bin:${PATH}"
### End ##############################################################
######################################################################



######################################################################
### oh-my-zsh ########################################################
######################################################################
# Setup oh-my-zsh
USER root
RUN apt install fonts-powerline
USER ${USERNAME}
# Install oh-my-zsh quietly
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# Copy .zshrc config
COPY ./configs/oh-my-zsh.zshrc ${HOME}/.zshrc
### End ##############################################################
######################################################################