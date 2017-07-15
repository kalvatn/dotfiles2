#!/bin/bash

function setup_discord() {
  if ! command -v discord > /dev/null; then
    echo "installing discord"
    if [ ! -f /tmp/discord.deb ]; then
      curl -fLo /tmp/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
      sudo dpkg -i /tmp/discord.deb
    fi
    sudo apt-get install -y -f
  fi
}

function setup_hipchat() {
  if ! command -v hipchat4 > /dev/null; then
    echo "installing hipchat"
    sudo sh -c 'echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client $(lsb_release -c -s) main" > /etc/apt/sources.list.d/atlassian-hipchat4.list'
    wget -O - https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install hipchat4
  fi
}

function setup_google_play_music() {
  if [ ! -f /tmp/google-play-music-desktop.deb ]; then
    curl -fLo /tmp/google-play-music-desktop.deb "https://github.com/MarshallOfSound/Google-Play-Music-Desktop-Player-UNOFFICIAL-/releases/download/v4.3.0/google-play-music-desktop-player_4.3.0_amd64.deb"
  fi
  sudo dpkg -i /tmp/google-play-music-desktop.deb
  sudo apt-get install -f
}

setup_discord
setup_hipchat
setup_google_play_music

echo "done"
exit 0
