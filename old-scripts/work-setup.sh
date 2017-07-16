#!/bin/bash


if [ -f /.dockerenv ]; then
  echo "RUNNING IN DOCKER CONTAINER"
  if [ -z "$USER" ]; then
    export USER="docker"
  fi
fi

export WORK=/work
export PROJECTS=$WORK/projects
export TOOLS=$WORK/tools

function setup_directories() {
  if [ ! -d $WORK ]; then
    sudo mkdir -p /work
    sudo chown -R $USER:$USER $WORK
  fi
  mkdir -p $PROJECTS/bac/java
  mkdir -p $PROJECTS/social
  mkdir -p $TOOLS/ide
  mkdir -p $TOOLS/sdk
}

function setup_vpn() {
  echo "installing openconnect"
  if ! command -v openconnect; then
    sudo apt-get install openconnect
    # sudo openconnect -b ra1.sportradar.com --user=<u.name>
    # echo "password" | sudo openconnect -b ra1.sportradar.com --user=<u.name> --passwd-on-stdin
  fi
}

function setup_java() {
  if ! command -v java; then
    echo "installing oracle-java"
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update -qq
    sudo apt-get install -y oracle-java8-installer
  fi
}

function setup_node() {
  echo "installing node 8.x"
}

function setup_node() {
  echo "installing node 8.x"
}

function setup_intellij() {
  echo "installing intellij UE -> $TOOLS/ide/intellij"
}

function setup_eclipse() {
  echo "downloading eclipse -> $TOOLS/ide/eclipse"
}

setup_directories
setup_vpn
setup_java


