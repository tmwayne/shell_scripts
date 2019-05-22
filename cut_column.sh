#!/bin/bash

# Usage: cut_column filename columnname

while getopts ":d:" opt; do
  case $opt in
    d)
      DELIM="-d $OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

if [[ $# -lt 1 ]]
then
  echo 'Usage: cut_column filename columname'
  exit 1
elif [[ $# -eq 1 ]]
then
  echo "cut_column doesn't currently work with standard in"
else
  FILE=$1
  COLUMN=$2
fi

let IND=$( print_header $DELIM $FILE | sed -n "/$COLUMN/=" )
IND="-f $IND"
cut $DELIM $IND $FILE
