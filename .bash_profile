#!/bin/bash
# Max prompt directory size when using
# "\w" in PS1
export PROMPT_DIRTRIM=2

# color variables and escaping hell
green="\[\033[1;92m\]"
blue="\[\033[1;94m\]"
reset="\[\033[1;0m\]"


# Git status, this will be printed behind the
# normal prompt
_git_prompt() {
  # Define local variables
  local ref
  local projectName
  # Grep the ref, this is used to get the branch name
  ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
  # Read the Project name, returns /path/to/git/project
  projectName="$(git rev-parse --show-toplevel 2>/dev/null)"

  # If there's anything inside the projectName variable get the basename which
  # is the folder the project lies in.
  if [ ! -z "$projectName" ]; then
    projectName="$(basename "$projectName")"
  fi

  if [ -n "$ref" ]; then
    echo "[$blue$projectName$reset on $green${ref#refs/heads/}$reset] "
  else
    echo "$green\u$reset in "
  fi
}

_build_path() {
  local cur_dir="\w"
  # CUR_DIR_OR_FILE="$(basename $(pwd))"
  echo "$blue$cur_dir"
}

# Assign the prompt once
PS1="$(_git_prompt)$(_build_path) $blue \n $blue➜ $reset"

# Used to re-build the prompt ➜
precmd() {
  PS1="$(_git_prompt)$(_build_path) $blue \n $blue➜ $reset"
}

# Switch to workspace or directly into a workspace directory if any is found
function ws() {
  # $1 is the target directory
  target_dir=$1
  # We start searching from the workspace dir
  cd ~/workspace
  # -maxdepth is the max directories to go "down"
  # head -n1 gives back the first result
  workspace_path=$(find -maxdepth 3 -type d -name "*$target_dir*" | head -n1)
  if [  -z "$workspace_path" ]; then
    echo "Directory '$target_dir' not found. Changing to ~/workspace"
  else
    cd "$workspace_path"
  fi
}

# quick zip function to create a zip of a directory with the same name
function qzip() {
 zip -r "$1.zip" "$1"
}

# pre exec need to be the last thing!
# See https://github.com/rcaloras/bash-preexec
 [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
