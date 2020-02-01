#!/bin/bash

USAGE='Usage: vim-dev repl [vim-args]'

## ARGUMENTS
##############################

while getopts ":e:" opt; do
  case $opt in
    h)
      echo $USAGE
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

REPL=$1
shift
VIM_ARGS=$@

SESSION=$$

## ASSERTIONS
##############################

if [ -z $REPL ] ; then
  echo $USAGE
  exit 1
fi

## MAIN
##############################

## Only start a new session if none exists
# if ! tmux ls > /dev/null 2>&1 ; then
if [ -z "$TMUX" ]; then 

  tmux new-session -s $SESSION -n SHELL -d

  tmux new-window -n IDE vim $VIM_ARGS
  tmux split-window -h $REPL
  tmux last-pane

  tmux -2 attach-session -t $SESSION

else

  ## IDE: Python IDE using Vim and IPython
  tmux new-window -n IDE vim $VIM_ARGS
  tmux split-window -h $REPL
  tmux last-pane

fi
  

