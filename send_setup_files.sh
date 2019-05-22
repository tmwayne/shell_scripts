#!/bin/bash

USAGE='Usage: send_setup_files [-f files] vm1 [vm2]'

while getopts ":f" opt; do
  case $opt in
    f)
      FILES=$OPTARG
      ;;
    h)
      echo $USAGE
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

BOXES=$@

if [ $# -eq 0 ] ; then
  # BOXES='sandbox bcg'
  BOXES='bcg'
fi

DEFAULT_FILES=$(echo $HOME/{.vimrc,.profile})
FILES=${FILES:-$DEFAULT_FILES}

for b in $BOXES ; do
  echo "Updating $b..."
  scp $FILES $b:/home/ubuntu
done

echo 'Success!'
