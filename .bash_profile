#!/bin/bash

# Make sure .bashrc is loaded.
source ~/.bashrc

# Up / Down arrow key for history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Quickly switch to a directory in my workspace.
function ws() {
  local workspace="${WS_WORKSPACE:=$HOME/Development}"
  # $1 is the target directory
  local target_dir="$1"
  depth=${WS_DEPTH:=3}
  # We start searching from the workspace dir
  cd $workspace
  # -maxdepth is the max directories to go "down"
  # head -n1 gives back the first result
  workspace_path=$(find . -maxdepth $depth -type d -name "*$target_dir*" | head -n1)
  if [  -z "$workspace_path" ]; then
    echo "Directory '$target_dir' not found. Changing to $workspace"
  else
    cd "$workspace_path"
  fi
}
