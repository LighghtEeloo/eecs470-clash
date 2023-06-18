"load-file" () {
  if [[ -e $1 ]]; then
    source $1
  fi
}

# Source header
load-file ~/.zshrcx/header.zsh

# Source Constants
load-file ~/.zshrcx/const.zsh

# Source aliases
load-file ~/.zshrcx/alias.zsh

# Source functions
load-file ~/.zshrcx/fn.zsh

# Source utilities
load-file ~/.zshrcx/utils.zsh

# Source programming languages
load-file ~/.zshrcx/lang.zsh

# Source custom
load-file ~/.zshrcx/custom.zsh
