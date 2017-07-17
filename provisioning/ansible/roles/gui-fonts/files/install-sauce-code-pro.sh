#!/bin/bash

set -e

FONT_DIR="/usr/share/fonts/truetype/sourcecodepro"
FONT_FILE="Sauce Code Pro Medium Nerd Font Complete Mono.ttf"
FONT_SIZE="10"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Medium/complete/$FONT_FILE?raw=true"
if [ ! -f "$FONT_DIR/$FONT_FILE" ]; then
  if [ ! -d "$FONT_DIR" ]; then
    sudo mkdir -p "$FONT_DIR"
  fi

  echo "downloading '$FONT_URL' -> '$FONT_DIR/$FONT_FILE'"
  sudo curl -s -L "${FONT_URL// /%20}" -o "$FONT_DIR/$FONT_FILE"
  echo "updating font-cache"
  sudo fc-cache -rf
fi
FONT_NAME="$(fc-query "$FONT_DIR/$FONT_FILE" -f "%{family} %{style}\n")"

if [ -z "$FONT_NAME" ]; then
  echo "could not find font $FONT_NAME"
  exit 1
fi
exit 0
