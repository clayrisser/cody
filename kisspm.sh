#!/bin/sh

export REPO=https://gitlab.com/risserlabs/community/kisspm.git

export _PREPARED=0

main() {
    install_kisspm
    if [ "$INSTALL" = "1" ]; then
        echo "installing $PACKAGE..."
        install $PACKAGE
        echo "installed $PACKAGE :)"
    elif [ "$UNINSTALL" = "1" ]; then
        echo "uninstalling $PACKAGE..."
        uninstall $PACKAGE
        echo "uninstalled $PACKAGE :)"
    elif [ "$REINSTALL" = "1" ]; then
        echo "reinstalling $PACKAGE..."
        reinstall $PACKAGE
        echo "reinstalled $PACKAGE :)"
    fi
}

install() {
    prepare
    export PACKAGE=$1
    if [ "$PACKAGE" = "kisspm" ]; then
        install_kisspm
    else
        (cd $HOME/.kisspm && TARGET=install make -s $PACKAGE)
    fi
}

uninstall() {
    prepare
    export PACKAGE=$1
    if [ "$PACKAGE" = "kisspm" ]; then
        uninstall_kisspm
    else
        (cd $HOME/.kisspm && TARGET=uninstall make -s $PACKAGE)
    fi
}

reinstall() {
    uninstall $1
    install $1
}

prepare() {
    if [ "$_PREPARED" = "1" ]; then
        if [ ! -d $HOME/.kisspm ]; then
            git clone $REPO $HOME/.kisspm
        else
            (cd $HOME/.kisspm && git pull origin main >/dev/null 2>/dev/null || true)
        fi
    fi
    export _PREPARED=1
}

install_kisspm() {
    if [ ! -f /usr/local/bin/kisspm ]; then
        (cd $HOME/.kisspm && make -s install)
    fi
}

uninstall_kisspm() {
    (cd $HOME/.kisspm && make -s uninstall)
}

implode_kisspm() {
    uninstall_kisspm
    rm -rf $HOME/.kisspm
}

if ! test $# -gt 0; then
    set -- "-h"
fi

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "kisspm - keep it simple stupid package manager"
            echo " "
            echo "kisspm [options] command"
            echo " "
            echo "options:"
            echo "-h, --help         show brief help"
            echo " "
            echo "commands:"
            echo "install=PACKAGE    specify an action to use"
            echo "uninstall=PACKAGE  specify a directory to store output in"
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
            unset UNINSTALL
            unset REINSTALL
            export INSTALL=1
            export PACKAGE=$1
        else
            echo "no package specified" 1>&2
            exit 1
        fi
        shift
    ;;
    u|uninstall)
        shift
        if test $# -gt 0; then
            unset INSTALL
            unset REINSTALL
            export UNINSTALL=1
            export PACKAGE=$1
        else
            echo "no package specified" 1>&2
            exit 1
        fi
        shift
    ;;
    reinstall)
        shift
        if test $# -gt 0; then
            unset INSTALL
            unset UNINSTALL
            export REINSTALL=1
            export PACKAGE=$1
        else
            echo "no package specified" 1>&2
            exit 1
        fi
        shift
    ;;
    *)
        echo "invalid command $1" 1>&2
        exit 1
    ;;
esac

main
