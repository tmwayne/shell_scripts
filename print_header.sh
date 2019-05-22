#!/bin/bash

# Usage: print_header [-d delim] filename 

while getopts ":d:" opt; do
  case $opt in
    d)
      DELIM=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

FILE="${1:-/dev/stdin}"
DELIM=${DELIM:-'\t'}

head -1 $FILE | sed "s/$DELIM/\n/g" 
