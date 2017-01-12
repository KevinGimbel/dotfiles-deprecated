#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Quickly switch to projects or workspace
function ws() {
  local workspace="$HOME/Development"
	# $1 is the target directory
  local target_dir="$1"
  # We start searching from the workspace dir
  cd $workspace
  # -maxdepth is the max directories to go "down"
  # head -n1 gives back the first result
  workspace_path=$(find . -maxdepth 3 -type d -name "*$target_dir*" | head -n1)
  if [  -z "$workspace_path" ]; then
    echo "Directory '$target_dir' not found. Changing to $workspace"
  else
    cd "$workspace_path"
  fi
}

# Customize to your needs...
# Search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-or-beginning-search
zle -N down-line-or-beginning-search
# Up/Down arrow for search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Custom aliases

if [[ -f "$HOME/.aliases" ]]; then
  source "$HOME/.aliases"
fi

# Paths
export GOPATH="$HOME/Development/go"
export GEM_HOME="/Users/kevingimbel/.gem"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:$HOME/Development/go/bin"
export PATH="$PATH:$HOME/bin"
