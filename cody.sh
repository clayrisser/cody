#!/bin/sh

MAKE=$(echo $(which remake 2>&1 >/dev/null && echo remake || echo $(which gmake 2>&1 >/dev/null && echo gmake || echo make)))
SED=$(echo $(which gsed 2>&1 >/dev/null && echo gsed || echo sed))
export _CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config/cody}"
export _STATE_PATH="${XDG_STATE_HOME:-$HOME/.local/state}/cody"
export _INSTALLED_PATH="$_STATE_PATH/installed"
export _REPOS_CONFIG_PATH="$_CONFIG_PATH/repos"
export _REPOS_PATH="$_STATE_PATH/repos"
export _DEFAULT_REPO=https://gitlab.com/bitspur/community/cody.git
if [ "$_TMP_PATH" = "" ]; then
    export _TMP_PATH="${XDG_RUNTIME_DIR:-$([ -d "/run/user/$(id -u $USER)" ] && echo "/run/user/$(id -u $USER)" || echo ${TMP:-${TEMP:-/tmp}})}/cody/$$"
fi

export _REPO=default

if echo $0 | grep -E "\.sh$" >/dev/null 2>/dev/null; then
    export _DEBUG_PATH="$(pwd)/$(echo $0 | $SED 's|\.\?\/\?[^\/]\+$||g')"
fi

main() {
    _prepare
    if [ "$_COMMAND" = "install" ]; then
        echo "installing $1..."
        _install $@
        echo "installed $1 :)"
        elif [ "$_COMMAND" = "uninstall" ]; then
        echo "uninstalling $1..."
        _uninstall $@
        echo "uninstalled $1 :)"
        elif [ "$_COMMAND" = "reinstall" ]; then
        echo "reinstalling $1..."
        _reinstall $@
        echo "reinstalled $1 :)"
        elif [ "$_COMMAND" = "dependencies" ]; then
        _dependencies $@
        elif [ "$_COMMAND" = "available" ]; then
        _available $@
        elif [ "$_COMMAND" = "installed" ]; then
        _installed $@
        elif [ "$_COMMAND" = "doctor" ]; then
        _doctor $@
        elif [ "$_COMMAND" = "wizard" ]; then
        _wizard $@
    fi
}

_install() {
    _INSTALLER=$1
    if [ "$_INSTALLER" = "cody" ]; then
        _install_cody
    else
        for d in $( _dependencies $_INSTALLER ); do
            _SKIP=0
            for i in $(_installed); do
                if [ "$d" = "$i" ]; then
                    _SKIP=1
                fi
            done
            if [ "$_SKIP" != "1" ]; then
                $(echo $0 | grep -E "\.sh$" >/dev/null && echo "sh $0" || echo cody) install $d
            fi
        done
        ( cd $_REPO_PATH && TARGET=install $MAKE -s $_INSTALLER || (echo "failed to install $_INSTALLER :(" && exit 1) ) || exit 1
    fi
}

_uninstall() {
    _INSTALLER=$1
    if [ "$_INSTALLER" = "cody" ]; then
        _uninstall_cody
    else
        ( cd $_REPO_PATH && TARGET=uninstall $MAKE -s $_INSTALLER || (echo "failed to uninstall $_INSTALLER :(" && exit 1) ) || exit 1
    fi
}

_available() {
    for p in $(ls $_REPO_PATH/installers 2>/dev/null || true | sort); do
        echo $p
    done
}

_installed() {
    ls $_INSTALLED_PATH 2>/dev/null | $SED 's|\s|\n|g' || true | sort
}

_dependencies() {
    _INSTALLER=$1
    ( cd $_REPO_PATH && TARGET=dependencies $MAKE -s $_INSTALLER ) || exit 1
}

_reinstall() {
    if [ "$_INSTALLER" != "cody" ]; then
        _uninstall $1
    fi
    _install $1
}

_prepare() {
    if [ ! -d "$_TMP_PATH" ]; then
        mkdir -p $_TMP_PATH
    fi
    _ensure_make
    _ensure_sed
    _load repos
    if [ ! -d "$_STATE_PATH" ]; then
        mkdir -p "$_STATE_PATH"
    fi
    _load_remote
    if [ "$_COMMAND" = "install" ] || [ "$_COMMAND" = "reinstall" ] || [ "$_COMMAND" = "uninstall" ]; then
        if [ ! -d $_REPO_PATH ]; then
            git clone --depth 1 $_REPO_REMOTE $_REPO_PATH
        else
            ( cd $_REPO_PATH && git pull origin main >/dev/null 2>/dev/null )
        fi
    fi
}

_load_remote() {
    if [ "$_DEBUG_PATH" = "" ]; then
        if [ ! -f "$_REPOS_CONFIG_PATH" ]; then
            mkdir -p $_CONFIG_PATH
            echo "default   $_DEFAULT_REPO" > $_REPOS_CONFIG_PATH
            export _REPO_REMOTE=$_DEFAULT_REPO
            export _REPO_PATH="$_REPOS_PATH/default"
        else
            export _REPO_REMOTE="$(eval $(echo 'echo $_repo_'$_REPO))"
            export _REPO_PATH="$_REPOS_PATH/$_REPO"
        fi
    else
        export _REPO_REMOTE=$_DEFAULT_REPO
        export _REPO_PATH="$_DEBUG_PATH"
    fi
    export CODY=$_REPO_PATH/cody.mk
}

_load() {
    (cat $HOME/.config/cody/$1 2>/dev/null || true) | \
    $SED "s|^\([^ \t]\+\)[ \t]\+|export _repo_\1='|g" | $SED "s|$|'|g" > \
    "$_TMP_PATH/load_$1.sh"
    . "$_TMP_PATH/load_$1.sh"
}

_install_cody() {
    _prepare
    ( cd $_REPO_PATH && $MAKE -s install ) || exit 1
}

_uninstall_cody() {
    ( cd $_REPO_PATH && unset _DEBUG_PATH && _load_remote && $MAKE -s uninstall ) || exit 1
}

_ensure_make() {
    if which $MAKE >/dev/null 2>/dev/null; then
        return 0
    fi
    if apt-get -v >/dev/null 2>/dev/null; then
        sudo apt-get install -y make
        elif brew -v >/dev/null 2>/dev/null; then
        brew install remake
    fi
}

_ensure_sed() {
    if which $SED >/dev/null 2>/dev/null; then
        return 0
    fi
    if apt-get -v >/dev/null 2>/dev/null; then
        sudo apt-get install -y sed
        elif brew -v >/dev/null 2>/dev/null; then
        brew install gsed
    fi
}

_wizard() {
    sh "$_REPO_PATH/wizard.sh"
}

_doctor() {
    for i in $(_installed); do
        _install $i
    done
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
            echo "    -h, --help                  show brief help"
            echo " "
            echo "commands:"
            echo "    install <INSTALLER>         install a installer"
            echo "    uninstall <INSTALLER>       uninstall a installer"
            echo "    reinstall <INSTALLER>       reinstall a installer"
            echo "    dependencies <INSTALLER>    dependencies required by installer"
            echo "    available                   list available installers"
            echo "    installed                   list installed installers"
            echo "    doctor                      fix potential problems"
            echo "    wizard                      run cody wizard"
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
            export _COMMAND=install
        else
            echo "no installer specified" 1>&2
            exit 1
        fi
    ;;
    u|uninstall)
        shift
        if test $# -gt 0; then
            export _COMMAND=uninstall
        else
            echo "no installer specified" 1>&2
            exit 1
        fi
    ;;
    reinstall)
        shift
        if test $# -gt 0; then
            export _COMMAND=reinstall
        else
            echo "no installer specified" 1>&2
            exit 1
        fi
    ;;
    d|dependencies)
        shift
        if test $# -gt 0; then
            export _COMMAND=dependencies
        else
            echo "no installer specified" 1>&2
            exit 1
        fi
    ;;
    a|available)
        shift
        export _COMMAND=available
    ;;
    installed)
        shift
        export _COMMAND=installed
    ;;
    doctor)
        shift
        export _COMMAND=doctor
    ;;
    wizard)
        shift
        export _COMMAND=wizard
    ;;
    *)
        echo "invalid command $1" 1>&2
        exit 1
    ;;
esac

main $@
