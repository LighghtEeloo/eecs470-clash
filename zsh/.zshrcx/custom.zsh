"screw-wifi" () {
    nmcli c down $1
    nmcli c up $1
}

"run-until" () {
    $1
    while [ $? -ne 0 ]
    do
        $1
    done
}

"goat" () {
    mv $1 $1.bak && touch $1
}

"cp-regex" () {
    fd "$1" . | xargs -I FOO dirname FOO | xargs -I FOO mkdir -p "$2/FOO"
    fd "$1" . | xargs -I FOO cp FOO "$2/FOO"
}

