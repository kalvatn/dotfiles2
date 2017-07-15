#!/bin/bash


echo "refreshing apt"
sudo apt-get update
sudo apt-get install -y curl

SOURCE=/home/$USER/dotfiles2
TARGET=/home/$USER

if [ -f /.dockerenv ]; then
  echo "RUNNING IN DOCKER CONTAINER"
  if [ -z "$USER" ]; then
    export USER="docker"
    SOURCE=/home/$USER/dotfiles
    TARGET=/home/$USER
  fi
fi


function setup_git() {
  sudo apt-get install -y git-core
  ln -sf $SOURCE/.gitconfig $TARGET/.gitconfig
  ln -sf $SOURCE/.gitignore-global $TARGET/.gitignore-global
}

function setup_vim() {
  sudo apt-get install -y neovim
  curl -fLo $TARGET/.local/share/nvim/site/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  mkdir -p $TARGET/.config/nvim
  ln -sf $SOURCE/.config/nvim/init.vim $TARGET/.config/nvim
  vim --headless +PlugInstall +UpdateRemotePlugins +PlugUpdate +qall!
}

function setup_zsh() {
  sudo apt-get install -y zsh
  sudo chsh -s /bin/zsh $USER
  curl -fLo $TARGET/.zshrc "https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc"
  ln -sf $SOURCE/.zshrc.local $TARGET/.zshrc.local
}

function setup_i3() {
  sudo apt-get install -y i3 i3blocks rofi
  ln -sf $SOURCE/.i3 $TARGET/.i3 -T
}

function setup_tmux() {
  sudo apt-get install -y tmux
  ln -sf $SOURCE/.tmux.conf $TARGET/.tmux.conf
}

setup_git
setup_vim
setup_zsh
setup_i3
setup_tmux


read -p "relog? (yes/no) "
if [ "$REPLY" == "yes" ]; then
  for i in $(seq 3 -1 1); do
    echo "logging out in $i seconds..."
    sleep 1
  done
  pkill -KILL -u $USER
fi
