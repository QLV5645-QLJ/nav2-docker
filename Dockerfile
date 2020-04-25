# This Dockerfile is used to build an headles vnc image based on Ubuntu

FROM ubuntu:18.04

## Connection ports for controlling the UI:
# VNC port:5903
# noVNC webport, connect via http://IP:6901/?password=vncpassword
ENV DISPLAY=:1 \
    VNC_PORT=5903 \
    NO_VNC_PORT=6903
EXPOSE $VNC_PORT $NO_VNC_PORT

### Envrionment config
ENV HOME=/root \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/headless/install \
    NO_VNC_HOME=/headless/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x720 \
    VNC_PW= \
    VNC_VIEW_ONLY=false
WORKDIR $HOME

### Add all install scripts for further steps
ADD ./src/common/install/ $INST_SCRIPTS/
ADD ./src/ubuntu/install/ $INST_SCRIPTS/
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ADD ./src/common/xfce/ $HOME/
ADD ./src/common/scripts $STARTUPDIR
COPY ./src/ros/install_nav2.sh $HOME/

### Install some common tools
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +
RUN $INST_SCRIPTS/tools.sh
RUN $INST_SCRIPTS/install_custom_fonts.sh
RUN $INST_SCRIPTS/tigervnc.sh
RUN $INST_SCRIPTS/no_vnc.sh
RUN $INST_SCRIPTS/xfce_ui.sh
RUN apt-get install -y gnome-terminal

### install ros deps
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
RUN $INST_SCRIPTS/set_user_permission.sh $HOME
RUN $HOME/install_nav2.sh
COPY src/ros/my_gazebo_launch.py /opt/ros/dashing/share/nav2_bringup/launch/

### configure startup
RUN $INST_SCRIPTS/libnss_wrapper.sh
COPY startup.sh $STARTUPDIR/
COPY src/ros/startup_rviz.sh $STARTUPDIR/
COPY src/ros/startup_gazebo.sh $STARTUPDIR/
COPY src/ros/startup_nav2.sh $STARTUPDIR/
COPY src/ros/startup_statepublish.sh $STARTUPDIR/
COPY src/ros/rviz2_maxWin.config $HOME/
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME

WORKDIR $HOME
USER 0
# ENTRYPOINT ["/dockerstartup/startup.sh"]
ENTRYPOINT ["/dockerstartup/startup.sh"]
# CMD ["--wait"]

