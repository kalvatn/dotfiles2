#!/bin/bash


echo "refreshing apt"
sudo apt-get update
sudo apt-get install -y curl

function setup_git() {
  sudo apt-get install -y git-core
  ln -sf ~/dotfiles2/.gitconfig ~/.gitconfig
  ln -sf ~/dotfiles2/.gitignore-global ~/.gitignore-global
}

function setup_vim() {
  sudo apt-get install neovim
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  mkdir -p ~/.config/nvim
  ln -sf ~/dotfiles2/.config/nvim/init.vim ~/.config/nvim
  vim +PlugInstall +UpdateRemotePlugins +PlugUpdate +qall!
}

function setup_zsh() {
  sudo apt-get install -y zsh
  sudo chsh -s /bin/zsh $USER
  curl -fLo ~/.zshrc "https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc"
  ln -sf ~/dotfiles2/.zshrc.local ~/.zshrc.local
}

function setup_i3() {
  sudo apt-get install -y i3 i3blocks rofi
  ln -sf ~/dotfiles2/.i3 ~/.i3 -T
}

function setup_tmux() {
  sudo apt-get install tmux
  ln -sf ~/dotfiles2/.tmux.conf ~/.tmux.conf
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
