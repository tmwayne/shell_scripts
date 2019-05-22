#!/bin/bash

# Usage: build_skeleton
PROG_NAME=$0

## CHECK FOR ARGUMENTS
while getopts ":o:c" opt; do
  case $opt in
    o)
      ROOT=$OPTARG
      ;;
    c)
      CLEANUP=TRUE
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

## CHECK FOR VALID ARGUMENTS
ROOT=${ROOT:-frontend}

if [ -e "$ROOT" ]
then
  echo "$PROG_NAME: Root directory already exists"
  exit 1
else
  mkdir "$ROOT"
fi

## FOR FLASK
## BUILD FOLDER SKELETON
DIRS="
  app/static/data
  app/static/css
  app/static/js
  app/templates
"
for dir in $DIRS
do
  echo "Making directory: $dir"
  mkdir -p "$ROOT/$dir"
done

## CREATE MINIMUM SET OF FILES 
FILES="
  LICENSE
  README.md
  config.py
  main.py
  start_frontend.sh
  app/__init__.py
  app/email.py
  app/errors.py
  app/forms.py
  app/models.py
  app/routes.py
  app/static/css/styles.css
  app/static/js/scripts.js
  app/templates/index.html
"

for f in $FILES
do
  echo "Making file: $f"
  touch "$ROOT/$f"
done

## DELETE SKELETON AFTER PROGRAM FINISHES
if [ "$CLEANUP" = "TRUE" ]
then
  rm -rf "$ROOT"
fi

