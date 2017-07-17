#!/bin/bash

set -e

function is_command() {
  command -v "$1" > /dev/null
}
function not_command() {
  ! is_command "$1"
}

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


echo "done"
exit 0

