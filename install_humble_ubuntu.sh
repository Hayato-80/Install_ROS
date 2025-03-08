#!/bin/bash

sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale

sudo apt install -y software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install -y curl gnupg lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update

sudo apt install -y ros-humble-desktop

cd
source /opt/ros/humble/setup.bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install -y python3-colcon-common-extensions python3-rosdep

sudo rosdep init
rosdep update

sudo apt install -y python3-argcomplete

sudo apt -y install gazebo
sudo apt install -y ros-humble-joint-state-publisher
sudo apt install -y ros-humble-gazebo-* 
sudo apt install -y ros-humble-rqt-* 

source /usr/share/gazebo/setup.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
source ~/ros2_ws/install/setup.bash

cd
mkdir -p ros2_ws/src
cd ~/ros2_ws
sudo apt install -y ros-humble-teleop-twist-keyboard

colcon build --symlink-install
source install/setup.bash
