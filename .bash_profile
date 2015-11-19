# Alias definitions.
if [ -f ~/.aliases ]; then
. ~/.aliases
fi

export PROMPT_DIRTRIM=2
# Color Variables and escaping hell
GREEN="\[\e[;92m\]"
RED="\[\e[;30m\]"
BLUE="\[\e[;94m\]"
RESET="\[\e[;0m\]"

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
PS1="$(_build_path)$(_git_prompt) $BLUE➜ $RESET"

# Used to re-build the prompt
precmd() {
  PS1="$(_build_path)$(_git_prompt) $BLUE➜ $RESET"
}

# pre exec need to be the last thing!
# See https://github.com/rcaloras/bash-preexec
 [[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh 
