#!/bin/bash


function install_virtualbox() {
  if ! command -v virtualbox > /dev/null; then
    echo "installing virtualbox"
    sudo apt-get install virtualbox virtualbox-guest-utils
  fi
}

function install_vagrant() {
  if ! command -v xmllint > /dev/null; then
    sudo apt-get install libxml2-utils
  fi
  if ! command -v vagrant > /dev/null; then
    VAGRANT_DEB_FILE="/tmp/vagrant.deb"
    if [ ! -f "$VAGRANT_DEB_FILE" ]; then
      deb_file_url="$(curl -sL "https://www.vagrantup.com/downloads.html" | xmllint --html --xpath "//a[contains(@href, 'x86_64.deb')]/@href" - 2> /dev/null | cut -d '"' -f2)"
      echo "downloading '$deb_file_url' -> '$VAGRANT_DEB_FILE'"
      curl -sLo "$VAGRANT_DEB_FILE" "$deb_file_url"
    fi
    echo "installing '$VAGRANT_DEB_FILE'"
    sudo dpkg -i "$VAGRANT_DEB_FILE"
  fi

}

install_virtualbox
install_vagrant
