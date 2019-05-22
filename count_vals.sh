#!/bin/bash

# Usage: count_vals filename columnname

while getopts ":d:" opt; do
  case $opt in
    d)
      ARGS="-d $OPTARG"
      DELIM=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

if [[ $# -lt 2 ]]
then
  echo 'Usage: count_vals filename columname'
  exit 1
elif [[ $# -eq 1 ]]
then
  echo "count_vals doesn't currently work with standard in"
fi

FILE=$1
COLUMN=$2

echo "count $COLUMN"
cut_column $ARGS $FILE $COLUMN | sort | uniq -c
