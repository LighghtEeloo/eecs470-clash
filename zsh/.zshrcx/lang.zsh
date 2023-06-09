# .local/bin
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ghcup
[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env" # ghcup-env
export PATH=$PATH:~/.ghcup/bin

# cabal
export PATH=$PATH:~/.cabal/bin

"veri-vvp" () {
    iverilog "$@" && vvp a.out -n && rm -f a.out
}

# git tricks

"git-contribution-line" () {
    git ls-files | while read f; do git blame -w -M -C -C --line-porcelain "$f" | grep -I '^author '; done | sort -f | uniq -ic | sort -n --reverse | cat
}

"git-contribution-commit" () {
    git shortlog -sn | cat
}

alias py=python3
alias ipy=ipython
