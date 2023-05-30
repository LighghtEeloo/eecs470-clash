mkcd () {
  mkdir -p "$1" && cd "$1"
}

cdls () {
  cd "$1" && ls
}

mount-label () {
    sudo mount /dev/disk/by-label/${1} /run/media/${1} --mkdir
}

"awesome-window-unminimize" () {
    awesome-client 'require("awful").client.restore():activate({ raise = true, context = "key.unminimize" })'
}

"awesome-restart" () {
    awesome-client 'awesome.restart()'
}

"kde-restart" () {
    killall plasmashell && kstart5 plasmashell > /dev/null 2>&1 & disown
    # kquitapp5 plasmashell && kstart5 plasmashell > /dev/null 2>&1 & disown
}

"sddm-restart" () {
    systemctl restart sddm
}

"xmodmap-show" () {
    xmodmap -pke | less
}

"tlp-check" () {
    sudo tlp-stat -b
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
