#!/bin/bash

sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale

sudo apt install curl gnupg2 lsb-release -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt install ros-humble-desktop -y

cd
source /opt/ros/humble/setup.bash
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install python3-colcon-common-extensions python3-rosdep -y
sudo rosdep init
rosdep update

sudo apt install python3-argcomplete -y

sudo apt -y install gazebo
sudo apt install ros-humble-gazebo-* -y
sudo apt install ros-humble-rqt-* -y

source /usr/share/gazebo/setup.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
source ~/ros2_ws/install/setup.bash

cd
mkdir -p ros2_ws/src
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src
sudo apt install ros-humble-teleop-twist-keyboard -y

colcon build --symlink-install
source ~/ros2_ws/install/setup.bash
