# Update and install various packages
apt-get update -q && \
apt-get upgrade -yq && \
apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata

# Create a user and give it sudo permissions
# useradd -m -d /home/ubuntu ubuntu -p $(perl -e 'print crypt("ubuntu", "salt"),"\n"') && \
#     echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Run and install ros2:dashing stuff
sudo apt install -y curl gnupg lsb-release
curl -Ls https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update
sudo apt install -y ros-dashing-desktop
sudo apt install -y python3-argcomplete python3-colcon-common-extensions
sudo apt install -y python-rosdep python3-vcstool # https://index.ros.org/doc/ros2/Installation/Linux-Development-Setup/
set +u

#install nav2
sudo apt install -y ros-dashing-navigation2
sudo apt install -y ros-dashing-nav2-bringup
sudo apt install -y ros-dashing-turtlebot3*