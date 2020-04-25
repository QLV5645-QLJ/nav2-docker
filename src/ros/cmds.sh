export TURTLEBOT3_MODEL=waffle; export GAZEBO_MODEL_PATH=:/opt/ros/dashing/share/turtlebot3_gazebo/models ;export GAZEBO_HOSTNAME=localhost;\
source /opt/ros/dashing/setup.bash; ros2 launch nav2_bringup my_gazebo_launch.py map:='/opt/ros/dashing/share/turtlebot3_navigation2/map/map.yaml' params:='/opt/ros/dashing/share/turtlebot3_navigation2/param/waffle.yaml'  use_sim_time:='true'
