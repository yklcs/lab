#/usr/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

if [ ! $(lsb_release -si) = "Ubuntu" ]; then
    printf "this script only works on ubuntu" >&2
    exit 1
fi

sudo apt update -y
sudo apt upgrade -y


NVIDIA_DRIVER_VERSION=$(nvidia-detector | sed s/nvidia-driver-//)
sudo apt install -y "nvidia-driver-$NVIDIA_DRIVER_VERSION" "nvidia-utils-$NVIDIA_DRIVER_VERSION"

# probably will need to reboot here
# sudo reboot


sudo apt install -y ca-certificates curl git


# install nvidia-container-toolkit

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit


# install docker

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker

git clone https://github.com/yklcs/lab --recursive
