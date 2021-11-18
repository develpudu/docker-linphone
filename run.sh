#!/bin/bash

# docker run
# docker run \
#     --env="DISPLAY" \
#     -e QT_QUICK_BACKEND="software" \
#     -e Qt5_DIR="/usr/lib/x86_64-linux-gnu/qt5/mkspecs/features/data/cmake" \
#     -e PATH='/usr/lib/x86_64-linux-gnu/qt5/bin':$PATH \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -v `pwd`./hosts:/etc/hosts \
#     -v "/run/user/1000/gdm/Xauthority:/run/user/1000/gdm/Xauthority:rw" \
#     -v "/run/user/1000/pulse:/run/user/1000/pulse" \
#     develpudu/linphone-docker

# compose
docker-compose up -d