#!/bin/bash
# Max prompt directory size when using
# "\w" in PS1
export PROMPT_DIRTRIM=2

# color variables
green="\[\033[1;32m\]"
pink="\[\033[1;95m\]"
blue="\[\033[1;36m\]"
cyan="\[\033[1;96m\]"
reset="\[\033[1;0m\]"
yellow="\[\033[1;33m\]"

ps1_dir="$cyan"
ps1_project_name="$blue"
ps1_git_remote="$pink"
ps1_last_icon="λ "
ps1_git_changes="$yellow"
ps1_git_untracked="$pink"
# Needs refactoring
# _git_remote_status() {
#   git fetch

#   LOCAL="$(git rev-parse @)"
#   REMOTE="$(git rev-parse @{u})"
#   BASE="$(git merge-base @ @{u})"

#   if [ "$LOCAL" = "$REMOTE" ]; then
#       echo "$green✓$reset"
#   elif [ "$LOCAL" = "$BASE" ]; then
#       echo "$green⇊$reset"
#   elif [ "$REMOTE" = "$BASE" ]; then
#       echo "$red⇈$reset"
#   fi
# }

_git_changed_files() {
  local changed
  changed="$(git status -s | grep -c "\sM")"
  if [ "$changed" -gt "0" ]; then
    echo -e "$ps1_git_changes⭿ $changed$reset"
  fi
}

_git_untracked_files() {
  local untracked
  untracked="$(git status -s | grep -c "??")"
  if [ "$untracked" -gt "0" ]; then
    echo -e "$ps1_git_untracked✖$untracked$reset|"
  fi
}

_git_stats() {
  local stats
  stats="$(_git_untracked_files)$(_git_changed_files)"
  if [ ! -z "$stats" ]; then
    echo -e "[$stats]"
  fi
}

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
    echo "[$ps1_project_name$projectName$reset on $ps1_git_remote${ref#refs/heads/}$reset]$(_git_stats) "
  else
    echo "$green\u$reset in "
  fi
}

_build_path() {
  local cur_dir="\w"
  # CUR_DIR_OR_FILE="$(basename $(pwd))"
  echo "$ps1_dir$cur_dir"
}

# Assign the prompt once
PS1="$(_git_prompt)$(_build_path) $ps1_dir \n $blue$ps1_last_icon $reset"

# Used to re-build the prompt ➜
precmd() {
  PS1="$(_git_prompt)$(_build_path) $ps1_dir \n $blue$ps1_last_icon $reset"
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

#
# WIP 
# http://fahdshariff.blogspot.de/2011/04/writing-your-own-bash-completion.html
# _wsComplete() {
#  local cur=${COMP_WORDS[COMP_CWORD]}
#  COMPREPLY=( $(compgen -W "$(find /home/kevin/workspace  \ -maxdepth 2 \ 
#  -type d -exec basename {} \;)" -- $cur) )
# }
# complete -F _wsComplete ws
#
# END WIP
#

# quick zip function to create a zip of a directory with the same name
function qzip() {
 zip -r "$1.zip" "$1"
}

# Create Calltracker URLs from git branches
function branch-calls() {
  git branch | awk -F'[^0-9]*' '$0=$2' | while read line; do echo "https://synoa.plan.io/issues/$line";  done
}

# pre exec need to be the last thing!
# See https://github.com/rcaloras/bash-preexec
# [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
