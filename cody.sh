#!/bin/sh

export REPO=https://gitlab.com/risserlabs/community/cody.git

main() {
    prepare
    if [ "$_INSTALL" = "1" ]; then
        echo "installing $_INSTALLER..."
        install $_INSTALLER
        echo "installed $_INSTALLER :)"
    elif [ "$_UNINSTALL" = "1" ]; then
        echo "uninstalling $_INSTALLER..."
        uninstall $_INSTALLER
        echo "uninstalled $_INSTALLER :)"
    elif [ "$_REINSTALL" = "1" ]; then
        echo "reinstalling $_INSTALLER..."
        reinstall $_INSTALLER
        echo "reinstalled $_INSTALLER :)"
    elif [ "$_AVAILABLE" = "1" ]; then
        for p in $(ls $HOME/.cody/installers); do
            echo $p
        done
    elif [ "$_INSTALLED" = "1" ]; then
        cat $HOME/.cody_installed
    fi
}

install() {
    export _INSTALLER=$1
    if [ "$_INSTALLER" = "cody" ]; then
        install_cody
    else
        ( cd $HOME/.cody && TARGET=install gmake -s $_INSTALLER || (echo "failed to install $_INSTALLER :(" && exit 1) ) || exit 1
    fi
}

uninstall() {
    export _INSTALLER=$1
    if [ "$_INSTALLER" = "cody" ]; then
        uninstall_cody
    else
        ( cd $HOME/.cody && TARGET=uninstall gmake -s $_INSTALLER || (echo "failed to uninstall $_INSTALLER :(" && exit 1) ) || exit 1
    fi
}

reinstall() {
    if [ "$_INSTALLER" != "cody" ]; then
        uninstall $1
    fi
    install $1
}

prepare() {
    if ! gmake -v >/dev/null 2>/dev/null; then
        install_gmake
    fi
    if [ ! -d $HOME/.cody ]; then
        git clone $REPO $HOME/.cody
    else
        ( cd $HOME/.cody && git pull origin main >/dev/null 2>/dev/null )
    fi
}

install_cody() {
    ( cd $HOME/.cody && gmake -s install ) || exit 1
}

uninstall_cody() {
    ( cd $HOME/.cody && gmake -s uninstall ) || exit 1
}

install_gmake() {
    if apt-get -v >/dev/null 2>/dev/null; then
        sudo apt-get install -y make
    elif brew -v >/dev/null 2>/dev/null; then
        brew install gmake
    fi
}

if ! test $# -gt 0; then
    set -- "-h"
fi

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "cody - simple universal installer"
            echo " "
            echo "cody [options] command <INSTALLER>"
            echo " "
            echo "options:"
            echo "    -h, --help             show brief help"
            echo " "
            echo "commands:"
            echo "    install <INSTALLER>      install a installer"
            echo "    uninstall <INSTALLER>    uninstall a installer"
            echo "    reinstall <INSTALLER>    reinstall a installer"
            echo "    available                list available installers"
            echo "    installed                list installed installers"
            exit 0
        ;;
        -*)
            echo "invalid option $1" 1>&2
            exit 1
        ;;
        *)
            break
        ;;
    esac
done

case "$1" in
    i|install)
        shift
        if test $# -gt 0; then
            export _INSTALL=1
            export _INSTALLER=$1
        else
            echo "no installer specified" 1>&2
            exit 1
        fi
        shift
    ;;
    u|uninstall)
        shift
        if test $# -gt 0; then
            export _UNINSTALL=1
            export _INSTALLER=$1
        else
            echo "no installer specified" 1>&2
            exit 1
        fi
        shift
    ;;
    reinstall)
        shift
        if test $# -gt 0; then
            export _REINSTALL=1
            export _INSTALLER=$1
        else
            echo "no installer specified" 1>&2
            exit 1
        fi
        shift
    ;;
    available)
        shift
        export _AVAILABLE=1
    ;;
    installed)
        shift
        export _INSTALLED=1
    ;;
    *)
        echo "invalid command $1" 1>&2
        exit 1
    ;;
esac

main
