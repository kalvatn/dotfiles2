#!/bin/bash

set -e
shopt -s extglob

CWD="$(dirname "$(readlink -f "$0")")"

PLAYBOOKS=("$(ls $CWD/playbook-*.yml | xargs -n1 basename | sed 's/playbook-\(.*\).yml/\1/g' | xargs)")

function usage() {
  echo "usage: $0 ($PLAYBOOKS)"
}

PLAYBOOK_NAME="$1"

if [ -z "$PLAYBOOK_NAME" ]; then
  if command -v fzf > /dev/null; then
    PLAYBOOK_NAME="$(echo "$PLAYBOOKS" | sed 's/ /\n/g' | fzf)"
  else
    usage
    exit 1
  fi
else
  shift 1
fi


PLAYBOOK_FILE="$CWD/playbook-$PLAYBOOK_NAME.yml"

if [ ! -f "$PLAYBOOK_FILE" ]; then
  echo "$PLAYBOOK_FILE does not exist"
  usage
  exit 1
fi

CMD="ansible-playbook -i $CWD/inventory $PLAYBOOK_FILE --become-password-file $CWD/.become-password-file $@"
echo "$CMD"
eval $CMD
