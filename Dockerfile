FROM ubuntu:zesty

RUN apt-get update && apt-get install apt-utils sudo -y
RUN useradd -ms /bin/bash docker
RUN echo "docker:docker" | chpasswd && adduser docker sudo

COPY ./docker/etc/sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers

USER docker
RUN export USER=docker
COPY . ~/dotfiles
WORKDIR ~/dotfiles
RUN ./bootstrap.sh
RUN ./core-setup.sh

