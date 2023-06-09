# .local/bin
append_path "$HOME/.local/bin"

# rust
append_path "$HOME/.cargo/bin"

# ghcup
[ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env" # ghcup-env
append_path "$HOME/.ghcup/bin"

# cabal
append_path "$HOME/.cabal/bin"

# git tricks
"git-contribution-line" () {
    git ls-files | while read f; do git blame -w -M -C -C --line-porcelain "$f" | grep -I '^author '; done | sort -f | uniq -ic | sort -n --reverse | cat
}

"git-contribution-commit" () {
    git shortlog -sn | cat
}

alias py=python3
alias ipy=ipython
