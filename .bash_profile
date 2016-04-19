# Max prompt directory size when using
# "\w" in PS1
export PROMPT_DIRTRIM=2

# Color Variables and escaping hell
GREEN="\[\e[;92m\]"
RED="\[\e[;30m\]"
BLUE="\[\e[;94m\]"
RESET="\[\e[;0m\]"
BOLD="\[\e[;33[1m\]"

# Git status, this will be printed behind the
# normal prompt
_git_prompt() {
  local ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
  if [ -n "$ref" ]; then
    echo "$RESET on $GREEN${ref#refs/heads/}$RESET"
  fi
}

_build_path() {
  CUR_PATH="\w"
  # CUR_DIR_OR_FILE="$(basename $(pwd))"
  echo "$BLUE$CUR_PATH" # $CUR_DIR_OR_FILE"
}

# Assign the prompt once
PS1="$(_build_path)$(_git_prompt) $BLUE \n➜ $RESET"

# Used to re-build the prompt ➜
precmd() {
  PS1="$(_build_path)$(_git_prompt) $BLUE\n➜ $RESET"
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
 zip -r $1.zip $1  
}

# pre exec need to be the last thing!
# See https://github.com/rcaloras/bash-preexec
 [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
