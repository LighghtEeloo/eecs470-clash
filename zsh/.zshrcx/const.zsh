export EDITOR="nvim"
export TERM=xterm-256color

# Check Machine and IS_MAC
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="${unameOut}"
esac
export MACHINE_IDENTIFIER=${machine}
if [ "${MACHINE_IDENTIFIER}" = "Mac" ]
then
export IS_MAC=TRUE
fi
