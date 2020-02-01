#!/bin/bash

# Usage: cut_column filename columnname

while getopts ":d:" opt; do
  case $opt in
    d)
      DELIM="$OPTARG"
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

DELIM=${DELIM:-'\t'}

echo $DELIM

# let IND=$( head -1 $FILE | sed "s/$DELIM/\\n/g" | sed -n "/$COLUMN/=" )
echo $( head -1 $FILE | sed "s/$DELIM/\n/g" )
# echo $IND
# IND="-f $IND"
# cut -d $DELIM -f $IND $FILE
