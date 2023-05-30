alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less
alias rm="rm -i"                          # confirm before rm
alias vp='vim -w PKGBUILD'

# alias cp='f(){fo=${1:--i}; shift; cp $fo $*};f'                                           # Confirm before overwriting something
# alias df='f(){if test $# -eq 0;then opts=(-h);else opts=("$@");fi; df "$opts[@]"};f'      # Human-readable sizes
# alias free='f(){if test $# -eq 0;then opts=(-m);else opts=("$@");fi; free "$opts[@]"};f'  # Show sizes in MB
# alias gitu='git add . && git commit && git push'

alias l="exa --icons"
alias ls="exa --icons"
alias la="exa --icons -a"
alias ll="exa --icons -l"
alias l1="exa --icons -1"
alias l2="exa --icons -T -L 2"
alias lt="exa --icons -T"
alias lla="exa --icons -al"
alias lr="exa --icons -R"
alias cat=bat
alias tree="exa --icons -T"

alias c="clear"
alias v="nvim"
alias e="emacs"

alias h="htop -s PERCENT_MEM -H"

# tmux
# alias t="tmux attach"
# alias tn="tmux new"
# alias tnn="tmux new -s 'oz' -n 'snow'"
# alias tl="tmux ls"

# alias canvassyncer-config="vim ~/.local/lib/python3.10/site-packages/canvassyncer/.canvassyncer.json"
# alias cvs="canvassyncer"

alias chr="charcoal query"
alias ww="charcoal query"

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
