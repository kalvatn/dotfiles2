#!/bin/bash

set -e
shopt -s extglob

CWD="$(dirname "$(readlink -f "$0")")"

PLAYBOOKS='+(vagrant|laptop|workstation|linode|wsl|dell-xps|dell-xps-new)'
function usage() {
  echo "usage: $0 ($PLAYBOOKS)"
}

# echo "args : $@"
case "$1" in
  $PLAYBOOKS)
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
