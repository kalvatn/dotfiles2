#!/bin/bash

set -e

function is_command() {
  command -v "$1" > /dev/null
}
function not_command() {
  ! is_command "$1"
}
function which_package() {
  dpkg -S "$(which "$1")" | cut -d ':' -f1
}

IN_DOCKER=false
if [ -f /.dockerenv ]; then
  echo "RUNNING IN DOCKER CONTAINER"
  if [ -z "$USER" ]; then
    IN_DOCKER=true
    export USER="docker"
  fi
fi

echo "USER : $USER"

if not_command apt-add-repository; then
  sudo apt-get install -y software-properties-common python-software-properties curl apt-transport-https
fi

if not_command git; then
  echo "installing git-core"
  sudo apt-get install git-core -y
fi

if not_command ansible; then
  echo "installing ansible"
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt-get update -qq
  sudo apt-get install ansible -y
fi

if ! $IN_DOCKER; then
  if is_command docker; then
    DOCKER_PACKAGE_INSTALLED="$(which_package "docker")"
    if [ "$DOCKER_PACKAGE_INSTALLED" != "docker-ce" ]; then
      echo "removing old docker versions"
      sudo apt-get remove docker docker-engine docker.io -y
    fi
  fi

  if not_command docker; then
    echo "installing docker-ce"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update -qq
    sudo sudo apt-get install docker-ce -y


    if ! id -nG $USER | grep -qw docker; then
      echo "adding user $USER to group docker"
      sudo usermod -a -G docker $USER
    fi
  fi

  if ! id -nG $USER | grep -qw docker; then
    read -p "relog required, logout now? (yes/no) "
    if [ "$REPLY" == "yes" ]; then
      echo "logging out.."
      sleep 3
      pkill -KILL -u $USER
    else
      echo "logout/login to apply user group changes"
    fi
  fi

fi

echo "done"
exit 0

