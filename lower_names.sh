#!/bin/bash

# Usage: lower_col_names filename

FILE=$1

if [ -z $FILE ]
then
  echo "Usage: lower_col_names filename"
  exit 1
fi

TMP=$(mktemp)
let LINES=$( wc -l $FILE | cut -d' ' -f1 )

sed -e '1s/.*/\L&/;1q' $FILE > $TMP
tail -$(( LINES - 1 )) $FILE >> $TMP

let NEW_LINES=$( wc -l $TMP | cut -d' ' -f1 )
if [[ $NEW_LINES -eq $LINES ]]
then
  mv $TMP $FILE
fi
