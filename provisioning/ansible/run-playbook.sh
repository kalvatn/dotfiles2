#!/bin/bash

CWD="$(dirname "$(readlink -f "$0")")"

function usage() {
  echo "usage: $0 (vagrant|laptop|workstation)"
}

echo "args : $@"
case "$1" in
  vagrant|laptop|workstation)
    PLAYBOOK_NAME="localhost-$1"
    shift 1
    ;;
  *)
    usage
    exit 1
esac

PLAYBOOK_FILE="$CWD/playbook-$PLAYBOOK_NAME.yml"

if [ ! -f "$PLAYBOOK_FILE" ]; then
  echo "$PLAYBOOK_FILE does not exist"
  exit 1
fi

echo "ansible-playbook -i $CWD/inventory $PLAYBOOK_FILE $@"
ansible-playbook -i "$CWD/inventory" "$PLAYBOOK_FILE" "$@"
