#!/bin/bash

USAGE='Usage: cookie_cutter [-d cookie_cutter_dir] [-n project_name] project_type [project_dir]'

## CONFIGURATIONS

DEFAULT_COOKIE_CUTTER_DIR="$HOME/scripts/skeletons/cookie_cutters"

## ARGUMENTS

while getopts ":hd:n:" opt; do
  case $opt in
    h)
      echo $USAGE
      exit 0
      ;;
    d)
      COOKIE_CUTTER_DIR=$OPTARG
      ;;
    n)
      PROJ_NAME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

COOKIE_CUTTER_DIR=${COOKIE_CUTTER_DIR:-$DEFAULT_COOKIE_CUTTER_DIR}
PROJ_TYPE=$1
COOKIE_CUTTER="$COOKIE_CUTTER_DIR/$PROJ_TYPE"

PROJ_DIR=${2:-$(pwd)}

PROJ_DEST="$PROJ_DIR/${PROJ_NAME:-$PROJ_TYPE}"


## ASSERTIONS

if [ "$#" -lt 1 ] ; then
  echo $USAGE
  exit 1
fi

if [ ! -d $COOKIE_CUTTER ] ; then
  echo 'Error: template for project type does not exist'
  exit 1
fi

if [ -d "$PROJ_DEST" ] ; then
  echo 'Error: project directory already exists'
  exit 1
fi


## MAIN

echo "Creating $PROJ_TYPE project in $PROJ_DIR"
cp -r $COOKIE_CUTTER $PROJ_DEST

echo 'Success!'
