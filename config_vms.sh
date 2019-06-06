#!/bin/bash

USAGE='Usage: send_setup_files [-f files] [-d dirs] [-p vm_path] vm1 [vm2]'

while getopts ":hf:d:" opt; do
  case $opt in
    h)
      echo $USAGE
      exit 0
      ;;
    f)
      FILES=$OPTARG
      ;;
    d)
      DIRS=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

BOXES=$@

if [ $# -eq 0 ] ; then
  BOXES='sandbox bcg'
fi

DEFAULT_FILES=$(echo $HOME/{.vimrc,.bash_profile,.bash_cheatsheet.txt})
FILES=${FILES:-$DEFAULT_FILES}

DEFAULT_DIRS=$(echo $HOME/.vim/{ftplugin,templates,snippets})
DIRS=${DIRS:-$DEFAULT_DIRS}

for b in $BOXES ; do
  echo "Updating $b..."
  scp $FILES $b:
  scp -r $DIRS $b:.vim
done

echo 'Success!'
