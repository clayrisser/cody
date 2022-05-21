#!/bin/sh

export REPO=https://gitlab.com/risserlabs/community/kisspm.git

main() {
    prepare
    if [ "$_INSTALL" = "1" ]; then
        echo "installing $_PACKAGE..."
        install $_PACKAGE
        echo "installed $_PACKAGE :)"
    elif [ "$_UNINSTALL" = "1" ]; then
        echo "uninstalling $_PACKAGE..."
        uninstall $_PACKAGE
        echo "uninstalled $_PACKAGE :)"
    elif [ "$_REINSTALL" = "1" ]; then
        echo "reinstalling $_PACKAGE..."
        reinstall $_PACKAGE
        echo "reinstalled $_PACKAGE :)"
    elif [ "$_AVAILABLE" = "1" ]; then
        for p in $(ls $HOME/.kisspm/packages); do
            echo $p
        done
    elif [ "$_INSTALLED" = "1" ]; then
        cat $HOME/.kisspm_installed
    fi
}

install() {
    export _PACKAGE=$1
    if [ "$_PACKAGE" = "kisspm" ]; then
        install_kisspm
    else
        ( cd $HOME/.kisspm && TARGET=install gmake -s $_PACKAGE || (echo "failed to install $_PACKAGE :(" && exit 1) ) || exit 1
    fi
}

uninstall() {
    export _PACKAGE=$1
    if [ "$_PACKAGE" = "kisspm" ]; then
        uninstall_kisspm
    else
        ( cd $HOME/.kisspm && TARGET=uninstall gmake -s $_PACKAGE || (echo "failed to uninstall $_PACKAGE :(" && exit 1) ) || exit 1
    fi
}

reinstall() {
    uninstall $1
    install $1
}

prepare() {
    if ! gmake -v >/dev/null 2>/dev/null; then
        install_gmake
    fi
    if [ ! -d $HOME/.kisspm ]; then
        git clone $REPO $HOME/.kisspm
    else
        ( cd $HOME/.kisspm && git pull origin main >/dev/null 2>/dev/null )
    fi
}

install_kisspm() {
    ( cd $HOME/.kisspm && gmake -s install ) || exit 1
}

uninstall_kisspm() {
    ( cd $HOME/.kisspm && gmake -s uninstall ) || exit 1
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
            echo "kisspm - keep it simple stupid package manager"
            echo " "
            echo "kisspm [options] command <PACKAGE>"
            echo " "
            echo "options:"
            echo "    -h, --help             show brief help"
            echo " "
            echo "commands:"
            echo "    install <PACKAGE>      install a package"
            echo "    uninstall <PACKAGE>    uninstall a package"
            echo "    reinstall <PACKAGE>    reinstall a package"
            echo "    available              list available packages"
            echo "    installed              list installed packages"
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
            export _PACKAGE=$1
        else
            echo "no package specified" 1>&2
            exit 1
        fi
        shift
    ;;
    u|uninstall)
        shift
        if test $# -gt 0; then
            export _UNINSTALL=1
            export _PACKAGE=$1
        else
            echo "no package specified" 1>&2
            exit 1
        fi
        shift
    ;;
    reinstall)
        shift
        if test $# -gt 0; then
            export _REINSTALL=1
            export _PACKAGE=$1
        else
            echo "no package specified" 1>&2
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
