#!/bin/sh

export _CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config/cody}"
export _STATE_PATH="${XDG_STATE_HOME:-$HOME/.local/state}/cody"
export _INSTALLED_PATH="$_STATE_PATH/installed"
export _REPOS_CONFIG_PATH="$_CONFIG_PATH/repos"
export _REPOS_PATH="$_STATE_PATH/repos"
export _DEFAULT_REPO=https://gitlab.com/risserlabs/community/cody.git
export _TMP_PATH="${XDG_RUNTIME_DIR:-$([ -d "/run/user/$(id -u $USER)" ] && echo "/run/user/$(id -u $USER)" || echo ${TMP:-${TEMP:-/tmp}})}/cody/$$"

export _REPO=default

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
        for p in $(ls $_REPO_PATH/installers 2>/dev/null || true); do
            echo $p
        done
    elif [ "$_INSTALLED" = "1" ]; then
        cat $_INSTALLED_PATH 2>/dev/null || true
    fi
}

install() {
    export _INSTALLER=$1
    if [ "$_INSTALLER" = "cody" ]; then
        install_cody
    else
        ( cd $_REPO_PATH && TARGET=install gmake -s $_INSTALLER || (echo "failed to install $_INSTALLER :(" && exit 1) ) || exit 1
    fi
}

uninstall() {
    export _INSTALLER=$1
    if [ "$_INSTALLER" = "cody" ]; then
        uninstall_cody
    else
        ( cd $_REPO_PATH && TARGET=uninstall gmake -s $_INSTALLER || (echo "failed to uninstall $_INSTALLER :(" && exit 1) ) || exit 1
    fi
}

reinstall() {
    if [ "$_INSTALLER" != "cody" ]; then
        uninstall $1
    fi
    install $1
}

prepare() {
    if [ ! -d "$_TMP_PATH" ]; then
        mkdir -p $_TMP_PATH
    fi
    if ! gmake -v >/dev/null 2>/dev/null; then
        install_gmake
    fi
    load repos
    if [ ! -d "$_STATE_PATH" ]; then
        mkdir -p "$_STATE_PATH"
    fi
    if [ ! -f "$_REPOS_CONFIG_PATH" ]; then
        mkdir -p $_CONFIG_PATH
        echo "default   $_DEFAULT_REPO" > $_REPOS_CONFIG_PATH
        export _REPO_REMOTE=$_DEFAULT_REPO
        export _REPO_PATH="$_REPOS_PATH/default"
    else
        export _REPO_REMOTE="$(eval $(echo 'echo $_repo_'$_REPO))"
        export _REPO_PATH="$_REPOS_PATH/$_REPO"
    fi
    if [ "$_INSTALL" = "1" ] || [ "$_REINSTALL" = "1" ] || [ "$_UNINSTALL" = "1" ]; then
        if [ ! -d $_REPO_PATH ]; then
            git clone $_REPO_REMOTE $_REPO_PATH
        else
            ( cd $_REPO_PATH && git pull origin main >/dev/null 2>/dev/null )
        fi
    fi
}

load() {
    (cat $HOME/.config/cody/$1 2>/dev/null || true) | \
        sed "s|^\([^ \t]\+\)[ \t]\+|export _repo_\1='|g" | sed "s|$|'|g" > \
        "$_TMP_PATH/load_$1.sh"
    . "$_TMP_PATH/load_$1.sh"
}

install_cody() {
    ( cd $_REPO_PATH && gmake -s install ) || exit 1
}

uninstall_cody() {
    ( cd $_REPO_PATH && gmake -s uninstall ) || exit 1
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
    a|available)
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
