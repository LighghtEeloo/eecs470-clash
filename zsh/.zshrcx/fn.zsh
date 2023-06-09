mkcd () {
  mkdir -p "$1" && cd "$1"
}

cdls () {
  cd "$1" && ls
}

mount-label () {
    sudo mount /dev/disk/by-label/${1} /run/media/${1} --mkdir
}

"date-time" () {
    date "+%Y/%m/%d %H:%M:%S %Z"
}

"self" () {
    $@ &>/dev/null & disown &>/dev/null
}

"alac" () {
    if [ -z $1 ]; then
      p=`pwd`
    else
      p=$1
    fi
    self alacritty --working-directory $p
}

"append_path" () {
    if [ -d "$1" ]; then
        export PATH="$PATH:$1"
    fi
}
