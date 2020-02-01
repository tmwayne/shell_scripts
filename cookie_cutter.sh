#!/bin/bash

usage='Usage: cookie_cutter [-d cookie_cutter_dir] [-D project_dir] project_type project_name'

## CONFIGURATIONS

default_cookie_cutter_dir="$HOME/scripts/skeletons/cookie_cutters"

## ARGUMENTS

while getopts ":hd:D:" opt; do
  case $opt in
    h)
      echo $usage
      exit 0
      ;;
    d)
      cookie_cutter_dir=$OPTARG
      ;;
    D)
      proj_dir=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

cookie_cutter_dir=${cookie_cutter_dir:-$default_cookie_cutter_dir}
proj_type=$1
cookie_cutter="$cookie_cutter_dir/$proj_type"

proj_dir=${proj_dir:-$(pwd)}
proj_name=$2

proj_dest="$proj_dir/$proj_name"


## ASSERTIONS

if [ "$#" -lt 2 ] ; then
  echo $usage
  exit 1
fi

if [ ! -d $cookie_cutter ] ; then
  echo 'Error: template for project type does not exist'
  exit 1
fi

if [ -d "$proj_dest" ] ; then
  echo 'Error: project directory already exists'
  echo "$proj_dest"
  exit 1
fi


## MAIN

printf "Creating $proj_type project in $proj_dir ... "
if cp -r $cookie_cutter $proj_dest; then
  echo 'Success!'
else
  echo 'Error'
  echo 'Unable to create cookie cutter project.'
fi
