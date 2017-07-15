FROM ubuntu:zesty

RUN apt-get update && apt-get install apt-utils sudo -y
RUN useradd -ms /bin/bash docker
RUN echo "docker:docker" | chpasswd && adduser docker sudo

COPY ./docker/etc/sudoers /etc/sudoers
RUN chmod 440 /etc/sudoers

COPY . /home/docker/dotfiles
RUN chown -R docker:docker /home/docker/

USER docker
RUN export USER=docker
RUN export USERNAME=docker
RUN export HOME=/home/docker

WORKDIR /home/docker/dotfiles

RUN ./bootstrap.sh
RUN ./core-setup.sh

