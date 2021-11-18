FROM ubuntu:bionic

ENV Qt5_DIR="/usr/lib/x86_64-linux-gnu/qt5/mkspecs/features/data/cmake"
ENV PATH='/usr/lib/x86_64-linux-gnu/qt5/bin'
ENV TZ=America/Argentina/Buenos_Aires
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
	build-essential \
	git \
    python-pip \
    python3-pip \
    qtbase5-dev \
    yasm \
    libV4l\* \
    libturbo\* \
    libglew-dev \
    libopus-dev \
    qtdeclarative5-dev \
    qml-module-qtquick-controls \
    libqt5svg5-dev \
    qttools5-dev \
    qtquickcontrols\* \
    qml-module-\*

RUN pip install pystache

RUN git config --global user.name "linphone user"
RUN git config --global user.email "linphone_user@example.net"

RUN git clone https://gitlab.linphone.org/BC/public/linphone-desktop.git linphone-desktop --recursive

RUN apt-get update && \
    apt-get install -y \
	cmake \
    doxygen \
    pkg-config \
    libpulse-dev \
    pulseaudio \
    apulse \
    libbsd-dev

RUN cd linphone-desktop && \
    mkdir build && \
    cd build && \
    cmake .. \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DENABLE_DOC=OFF \
        -DENABLE_AMRWB=ON \
        -DENABLE_AMRNB=ON \
        -DENABLE_NON_FREE_CODECS=ON \
        -DENABLE_G729=ON \
        -DCMAKE_BUILD_PARALLEL_LEVEL=10

RUN cd linphone-desktop/build && \
    cmake --build . --target all

ENV UNAME linphone

# Set up the user
RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    gpasswd -a ${UNAME} audio

COPY pulse-client.conf /etc/pulse/client.conf
COPY hosts /etc/hosts

USER $UNAME
ENV HOME /home/linphone

CMD /linphone-desktop/build/OUTPUT/bin/linphone