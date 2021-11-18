FROM ubuntu:bionic
#FROM buildpack-deps:bionic

ENV TZ=America/Argentina/Buenos_Aires
ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && \
#     apt-get install -y \ 
#     software-properties-common

# RUN add-apt-repository \
#     #ppa:linphone/release \
#     ppa:rayanayar/linphone

# RUN apt-get update && \
#     apt-get install -y \
# 	linphone \
#     doxygen \
#     pkg-config \
#     pulseaudio \
#     apulse 

RUN apt-get update && apt-get install -y \ 
    linphone \
    doxygen \
    pkg-config \
    pulseaudio \
    apulse 

# ENV UNAME linphone

# # Set up the user
# RUN export UNAME=$UNAME UID=1000 GID=1000 && \
#     mkdir -p "/home/${UNAME}" && \
#     echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
#     echo "${UNAME}:x:${UID}:" >> /etc/group && \
#     mkdir -p /etc/sudoers.d && \
#     echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
#     chmod 0440 /etc/sudoers.d/${UNAME} && \
#     chown ${UID}:${GID} -R /home/${UNAME} && \
#     gpasswd -a ${UNAME} audio

COPY DockerMain.sh /
COPY pulse-client.conf /etc/pulse/client.conf
COPY hosts /etc/hosts

# USER $UNAME
#ENV HOME /home/linphone

RUN export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"

CMD ["linphone"]
#RUN chmod +x /DockerMain.sh

#ENTRYPOINT ["/DockerMain.sh"]