# Use an official Ubuntu 20.04 LTS as a parent image
FROM osrf/ros:noetic-desktop-full

# Set noninteractive to avoid prompts during the build
ARG DEBIAN_FRONTEND=noninteractive

# Update apt package list and install general packages
RUN apt-get update && \
    apt-get install -y \
    curl\
    python3-pip
    
RUN pip install readchar
RUN pip install PyYaml
RUN pip install urdf-parser-py

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR workspace


# Set the default command to execute
# When creating a container, this will simulate `docker run -it`
CMD ["bash"]