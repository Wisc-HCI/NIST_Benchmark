#! /usr/bin/env bash

# Create a label from git branch or commit hash of the parent directory or latest
GIT_LABEL="$(git -C .. branch --show-current | tr / -)"
if [[ -z "$GIT_LABEL" ]]; then
    GIT_LABEL="$(git -C .. rev-parse --short HEAD)"
    if [[ -z "$GIT_LABEL" ]]; then
        GIT_LABEL="latest"
    fi
fi

# Image Tag and Container Name
export IMAGE_TAG="WiscHCI/panda-ros:${GIT_LABEL}"
export CONTAINER_NAME="ros-panda-noetic"

# User configs
export USERNAME=$(whoami)
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
# export DISPLAY=${DISPLAY}

# Volume Settings
ENTERPOINT_DIR="$(dirname $(realpath "$0"))"    # Get enterpoints's absolute directory path
export HOME_PATH="/home/${USERNAME}"
export WORKSPACE_PATH="${HOME_PATH}/workspace"