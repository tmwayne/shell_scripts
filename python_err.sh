#!/bin/bash

# Usage: python_err script [args]
# Description: If script throws an error,
# it will be opened in VIM with line number at error

if [ $# -eq 0 ]
then
  echo 'Usage: python_err script [args]'
  exit 1
fi

SCRIPT=$1

exec 3>&1 4>&2

SE=$(( python "$@" ) 2>&1 >/dev/null )

if [ -n "$SE" ]
then
  echo "$SE"
  read -p "Press any key to open file in VIM"
  LINE=$(echo "$SE" | sed -n '/<module>/s/.*line \([0-9]*\).*/\1/p')
  vim +$LINE $1
fi
  
