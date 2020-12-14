#!/bin/bash

set -e


# curl https://nixos.org/nix/install | sh

# ~/.zshrc.local
# export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libgtk3-nocsd.so.0
# . /home/kalvatn/.nix-profile/etc/profile.d/nix.sh
# eval "$(direnv hook zsh)"
# nixify() {
#   if [ ! -e ./.envrc ]; then
#     echo "use nix" > .envrc
#     direnv allow
#   fi
#   if [ ! -e default.nix ]; then
#     cat > default.nix <<'EOF'
# with import <nixpkgs> {};
# stdenv.mkDerivation {
#   name = "env";
#   buildInputs = [
#     bashInteractive
#   ];
# }
# EOF
#     ${EDITOR:-vim} default.nix
#   fi
# }
nix-env -i any-nix-shell -f https://github.com/NixOS/nixpkgs/archive/master.tar.gz
nix-env -i direnv
#nix-env -f https://github.com/kalbasit/nur-packages/archive/master.tar.gz -iA nixify




