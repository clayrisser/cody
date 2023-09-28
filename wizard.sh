#!/bin/bash

LANGUAGES="
cpp
golang
java
javascript
php
python
react-native
ruby
rust
solidity
terraform
"

TOOLS="
android-studio
aws
chatgpt
cursor
dbgate
debian
docker
kube
nixos
shell
"

if [ "$1" != "_ready" ]; then
    bash $0 _ready $@
    exit $?
fi
sudo true

kwyzod() {
    while [ $# -gt 0 ]; do
        case "$1" in
        --dialogs)
            KWYZOD_DIALOGS="$2"
            shift 2
            ;;
        --default | -d)
            KWYZOD_DEFAULT="$2"
            shift 2
            ;;
        --multiple | -m)
            _ENUM_MULTIPLE="1"
            shift
            ;;
        *)
            break
            ;;
        esac
    done
    _TYPE="$1"
    shift
    while [ $# -gt 0 ]; do
        case "$1" in
        --default | -d)
            KWYZOD_DEFAULT="$2"
            shift 2
            ;;
        --multiple | -m)
            _ENUM_MULTIPLE="1"
            shift
            ;;
        *)
            break
            ;;
        esac
    done
    case "$_TYPE" in
    dialogs)
        _kwyzod_dialogs "$@"
        ;;
    boolean)
        _kwyzod_boolean "$KWYZOD_DEFAULT" "$@"
        ;;
    string)
        _kwyzod_string "$KWYZOD_DEFAULT" "$@"
        ;;
    integer)
        _kwyzod_integer "$KWYZOD_DEFAULT" "$@"
        ;;
    enum)
        if [ -z "$_ENUM_MULTIPLE" ]; then
            _kwyzod_select "$KWYZOD_DEFAULT" "$@"
        else
            _kwyzod_multiselect "$KWYZOD_DEFAULT" "$@"
        fi
        ;;
    *)
        _kwyzod_help
        ;;
    esac
}

_kwyzod_help() {
    cat <<EOF
Usage: kwyzod <OPTIONS> [COMMAND] <TYPE_OPTIONS> <PROMPT>

[COMMAND]:
    dialogs              list installed dialogs
    boolean              prompt for a boolean value
    string               prompt for a string value
    integer              prompt for an integer value
    enum [...options]    prompt for an enum value

<OPTIONS>:
    --default, -d     set the default value
    --dialogs         comma separated list of ordered dialogs to use (eg: "zenity,dialog")
    --help, -h        display this help
    --multiple, -m    allow multiple selections (only for enum)
    --version, -v     display version

<TYPE_OPTIONS>:
    --default, -d     set the default value
    --multiple, -m    allow multiple selections (only for enum)

<PROMPT>: prompt displayed in the dialog box
EOF
}

_error() {
    echo "$@" >&2
}

_kwyzod_detect_dialogs() {
    _DIALOGS=""
    if [ -z "$KWYZOD_DIALOGS" ]; then
        if [ "$(uname)" = "Darwin" ]; then
            KWYZOD_DIALOGS="osascript zenity yad kdialog"
        elif [ "$(uname)" = "Linux" ]; then
            if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
                KWYZOD_DIALOGS="kdialog zenity yad"
            else
                KWYZOD_DIALOGS="zenity yad kdialog"
            fi
        fi
        KWYZOD_DIALOGS="$KWYZOD_DIALOGS dialog whiptail"
    else
        KWYZOD_DIALOGS="$(echo "$KWYZOD_DIALOGS" | tr ',' ' ')"
    fi
    for _DIALOG in $KWYZOD_DIALOGS; do
        if command -v "$_DIALOG" >/dev/null 2>&1; then
            _DIALOGS="$_DIALOGS $_DIALOG"
        fi
    done
    echo "$_DIALOGS"
}

_kwyzod_get_dialog() {
    _SUPPORTED_DIALOGS="$@"
    _INSTALLED_DIALOGS="$(_kwyzod_detect_dialogs)"
    _DIALOG=""
    for d in $_INSTALLED_DIALOGS; do
        if echo " $_SUPPORTED_DIALOGS " | grep -q " $d "; then
            _DIALOG="$d"
            break
        fi
    done
    echo "$_DIALOG"
}

_kwyzod_dialogs() {
    _kwyzod_detect_dialogs | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr ' ' '\n'
}

_kwyzod_boolean() {
    _DEFAULT="$1"
    _PROMPT="$2"
    _RESULT=""
    _DIALOG=$(_kwyzod_get_dialog "osascript" "zenity" "kdialog" "yad" "dialog" "whiptail")
    if [ -z "$_DIALOG" ]; then
        printf "%s [Y|n]: " "$_PROMPT"
        read -r _ANSWER
        case "$_ANSWER" in
        [Nn]*)
            _RESULT="0"
            ;;
        *)
            _RESULT="1"
            ;;
        esac
    else
        case "$_DIALOG" in
        osascript)
            _OSASCRIPT_OUTPUT="$(osascript -e 'tell application "System Events" to display dialog '"\"$_PROMPT\""' buttons {"Yes", "No"} default button "Yes" giving up after 86400' -e 'button returned of result')"
            _RESULT="$([ "$_OSASCRIPT_OUTPUT" = "Yes" ] && echo "1" || echo "0")"
            ;;
        zenity)
            _RESULT="$(zenity --question --text "$_PROMPT" && echo "1" || echo "0")"
            ;;
        kdialog)
            _RESULT="$(kdialog --yesno "$_PROMPT" && echo "1" || echo "0")"
            ;;
        yad)
            _RESULT="$(yad --question --text "$_PROMPT" && echo "1" || echo "0")"
            ;;
        dialog)
            dialog --yesno "$_PROMPT" 10 40 2>&1 >/dev/tty && _RESULT="1" || _RESULT="0"
            ;;
        whiptail)
            whiptail --yesno "$_PROMPT" 10 40 --yes-button "Yes" --no-button "No" && _RESULT="1" || _RESULT="0"
            ;;
        esac
    fi
    echo "$_RESULT"
}

_kwyzod_string() {
    _DEFAULT="$1"
    _PROMPT="$2"
    _RESULT=""
    _DIALOG=$(_kwyzod_get_dialog "osascript" "zenity" "kdialog" "yad" "dialog" "whiptail")
    if [ -z "$_DIALOG" ]; then
        if [ -z "$_DEFAULT" ]; then
            printf "%s: " "$_PROMPT"
        else
            printf "%s (%s): " "$_PROMPT" "$_DEFAULT"
        fi
        read -r _RESULT
        if [ -z "$_RESULT" ]; then
            _RESULT="$_DEFAULT"
        fi
    else
        case "$_DIALOG" in
        osascript)
            _RESULT=$(
                osascript <<EOF
            text returned of (display dialog "$_PROMPT" default answer "$_DEFAULT" buttons {"OK"} default button 1)
EOF
            )
            ;;
        zenity)
            _RESULT="$(zenity --entry --text "$_PROMPT" --entry-text="$_DEFAULT")"
            ;;
        kdialog)
            _RESULT="$(kdialog --inputbox "$_PROMPT" "$_DEFAULT")"
            ;;
        yad)
            _RESULT="$(yad --entry --text="$_PROMPT" --entry-text="$_DEFAULT")"
            ;;
        dialog)
            _RESULT="$(dialog --inputbox "$_PROMPT" 10 40 "$_DEFAULT" 3>&1 1>&2 2>&3)"
            ;;
        whiptail)
            _RESULT="$(whiptail --inputbox "$_PROMPT" 10 40 "$_DEFAULT" 3>&1 1>&2 2>&3)"
            ;;
        esac
    fi
    echo "$_RESULT"
}

_kwyzod_integer() {
    _DEFAULT="$1"
    _PROMPT="$2"
    _RESULT=""
    _DIALOG="$(_kwyzod_get_dialog "osascript" "zenity" "kdialog" "yad" "dialog" "whiptail")"
    if [ -z "$_DIALOG" ]; then
        if [ -z "$_DEFAULT" ]; then
            printf "%s: " "$_PROMPT"
        else
            printf "%s (%s): " "$_PROMPT" "$_DEFAULT"
        fi
        read -r _RESULT
        if [ -z "$_RESULT" ]; then
            _RESULT="$_DEFAULT"
        fi
    else
        case "$_DIALOG" in
        osascript)
            _RESULT=$(
                osascript <<EOF
                text returned of (display dialog "$_PROMPT" default answer "$_DEFAULT" buttons {"OK"} default button 1)
EOF
            )
            ;;
        zenity)
            _RESULT="$(zenity --entry --text "$_PROMPT" --entry-text="$_DEFAULT")"
            ;;
        kdialog)
            _RESULT="$(kdialog --inputbox "$_PROMPT" "$_DEFAULT")"
            ;;
        yad)
            _RESULT="$(yad --form --text="$_PROMPT" --field="":NUM "$_DEFAULT" | sed 's/|[[:space:]]*$//'))"
            ;;
        dialog)
            _RESULT="$(dialog --inputbox "$_PROMPT" 10 40 "$_DEFAULT" 3>&1 1>&2 2>&3)"
            ;;
        whiptail)
            _RESULT="$(whiptail --inputbox "$_PROMPT" 10 40 "$_DEFAULT" 3>&1 1>&2 2>&3)"
            ;;
        esac
    fi
    _RESULT="$(echo "$_RESULT" | cut -d'.' -f1)"
    _RESULT="$(echo "$_RESULT" | tr -d -c 0-9)"
    if [ -z "$_RESULT" ]; then
        _RESULT="0"
    fi
    echo "$_RESULT"
}

_kwyzod_select() {
    _DEFAULT="$1"
    _PROMPT="$2"
    shift 2
    set -- "$@"
    _RESULT=""
    _DIALOG=$(_kwyzod_get_dialog "osascript" "zenity" "kdialog" "yad" "dialog" "whiptail")
    if [ -z "$_DIALOG" ]; then
        _OPTIONS=""
        for _OPTION in "$@"; do
            if [ "$_OPTION" != "$_DEFAULT" ]; then
                _OPTIONS="$_OPTIONS \"$_OPTION\""
            fi
        done
        eval set -- $_OPTIONS
        if [ -n "$_DEFAULT" ]; then
            set -- "$_DEFAULT" "$@"
        fi
        i=1
        for _OPTION; do
            if [ "$_OPTION" == "$_DEFAULT" ]; then
                printf "*%s) %s\n" "$i" "$_OPTION"
            else
                if [ -z "$_DEFAULT" ]; then
                    printf "%s) %s\n" "$i" "$_OPTION"
                else
                    printf " %s) %s\n" "$i" "$_OPTION"
                fi
            fi
            i="$((i + 1))"
        done
        printf "%s: " "$_PROMPT"
        read -r _RESULT
        if [ -z "$_RESULT" ]; then
            _RESULT="$_DEFAULT"
        else
            _RESULT="$(eval "echo \$$((_RESULT))")"
        fi
    else
        case "$_DIALOG" in
        osascript)
            if [ -n "$_DEFAULT" ]; then
                _OPTIONS="\"$_DEFAULT\""
            fi
            for _OPTION; do
                if [ "$_OPTION" != "$_DEFAULT" ]; then
                    _OPTIONS="$_OPTIONS, \"$_OPTION\""
                fi
            done
            _RESULT="$(osascript -e "choose from list {$_OPTIONS} with prompt \"$_PROMPT\"")"
            ;;
        zenity)
            if [ -n "$_DEFAULT" ]; then
                _OPTIONS="\"$_DEFAULT\""
            fi
            for _OPTION in "$@"; do
                if [ "$_OPTION" != "$_DEFAULT" ]; then
                    _OPTIONS="$_OPTIONS \"$_OPTION\""
                fi
            done
            _RESULT="$(eval zenity --list --text=\"$_PROMPT\" --column=\"Options\" $_OPTIONS)"
            ;;
        kdialog)
            _RESULT="$(kdialog --radiolist "$_PROMPT" "$_DEFAULT" "$@")"
            ;;
        yad)
            _OPTIONS="$_DEFAULT"
            for _OPTION; do
                if [ "$_OPTION" != "$_DEFAULT" ]; then
                    _OPTIONS="$_OPTIONS\!$_OPTION"
                fi
            done
            _RESULT="$(yad --form --text="$_PROMPT" --field="":CB "$_OPTIONS" | sed 's/|[[:space:]]*$//')"
            ;;
        dialog)
            if [ -n "$_DEFAULT" ]; then
                _OPTIONS="\"$_DEFAULT\" \"1\" \"on\""
                _COUNT=2
            else
                _COUNT=1
            fi
            i=1
            while [ $i -le $# ]; do
                _OPTION="$(eval "echo \$$i")"
                if [ "$_OPTION" != "$_DEFAULT" ]; then
                    _OPTIONS="$_OPTIONS \"$_OPTION\" \"$_COUNT\" \"off\""
                    _COUNT="$((_COUNT + 1))"
                fi
                i="$((i + 1))"
            done
            _RESULT="$(eval dialog --radiolist \"$_PROMPT\" 15 40 10 $_OPTIONS 3>&1 1>&2 2>&3)"
            ;;
        whiptail)
            _RESULT="$(whiptail --menu "$_PROMPT" 15 40 10 "$_DEFAULT" "$@" 3>&1 1>&2 2>&3)"
            ;;
        esac
    fi
    echo "$_RESULT"
}

_kwyzod_multiselect() {
    _DEFAULT="$1"
    _PROMPT="$2"
    shift 2
    set -- "$@"
    _RESULT=""
    _DIALOG=$(_kwyzod_get_dialog "osascript" "zenity" "kdialog" "yad" "dialog" "whiptail")
    if [ -z "$_DIALOG" ]; then
        i=1
        for _OPTION; do
            printf "%s) %s\n" "$i" "$_OPTION"
            i="$((i + 1))"
        done
        printf "%s: " "$_PROMPT"
        read -r _RESULTS
        _RESULT=""
        for _INDEX in $_RESULTS; do
            _RESULT+="$(eval "echo \$$_INDEX")\n"
        done
        _RESULT="${_RESULT%\\n}"
    else
        case "$_DIALOG" in
        osascript)
            _OPTIONS="$(printf ", \"%s\"" "$@")"
            _OPTIONS="$(echo "$_OPTIONS" | cut -c 3-)"
            _RESULT="$(osascript -e "choose from list {$_OPTIONS} with prompt \"$_PROMPT\" with multiple selections allowed")"
            _RESULT="$(echo "$_RESULT" | sed 's/, /\n/g')"
            ;;
        zenity)
            _RESULT="$(zenity --list --multiple --text="$_PROMPT" --column="Options" "$@" | sed 's/|/\n/g')"
            ;;
        kdialog)
            _RESULT="$(kdialog --checklist "$_PROMPT" "$@")"
            ;;
        yad)
            _OPTIONS=""
            for _OPTION; do
                _OPTIONS="$_OPTIONS --field=\"$_OPTION\":CHK"
            done
            _RESULT="$(eval yad --form --text=\"$_PROMPT\" $_OPTIONS)"
            _RESULT="$(echo "$_RESULT" | tr '|' '\n')"
            _INDEX=1
            for _VALUE in $_RESULT; do
                if [ "$_VALUE" = "TRUE" ]; then
                    _RESULT+="$(eval "echo \$$_INDEX")|"
                fi
                _INDEX="$((_INDEX + 1))"
            done
            _RESULT="$(echo "${_RESULT%?}" | sed 's/|/\n/g')"
            ;;
        dialog)
            _OPTIONS=""
            i=1
            while [ $i -le $# ]; do
                _OPTIONS="$_OPTIONS \"$(eval "echo \$$i")\" \"$i\" \"off\""
                i="$((i + 1))"
            done
            _RESULT="$(eval dialog --checklist \"$_PROMPT\" 15 40 10 $_OPTIONS 3>&1 1>&2 2>&3)"
            _RESULT="$(echo "$_RESULT" | awk 'BEGIN{RS="\"";ORS="\n"}{if(NR%2==0){print $0}else{gsub(/ /,"\n");print $0}}' | awk 'NF')"
            ;;
        whiptail)
            _RESULT="$(whiptail --checklist "$_PROMPT" 15 40 10 "$@" 3>&1 1>&2 2>&3)"
            ;;
        esac
    fi
    echo "$_RESULT"
}

installed() {
    for i in $@; do
        if (echo $(cody installed) | grep -qE "(^|\s)$i($|\s)"); then
            echo $i
        fi
    done
}

not_installed() {
    for i in $@; do
        if (echo $(cody installed) | grep -vqE "(^|\s)$i($|\s)"); then
            echo $i
        fi
    done
}

if [ "$(installed $LANGUAGES)" != "" ]; then
    LANGUAGES_UNINSTALL=$(kwyzod enum -m "select the languages you wish to uninstall" $(installed $LANGUAGES))
    if [ "$LANGUAGES_UNINSTALL" != "" ] && [ "$(kwyzod boolean "UNINSTALL LANGUAGES\n\n$LANGUAGES_UNINSTALL")" != "1" ]; then
        exit 1
    fi
fi

if [ "$(not_installed $LANGUAGES)" != "" ]; then
    LANGUAGES_INSTALL=$(kwyzod enum -m "select the languages you wish to install" $(not_installed $LANGUAGES))
    if [ "$LANGUAGES_INSTALL" != "" ] && [ "$(kwyzod boolean "INSTALL LANGUAGES\n\n$LANGUAGES_INSTALL")" != "1" ]; then
        exit 1
    fi
fi

if [ "$(installed $TOOLS)" != "" ]; then
    TOOLS_UNINSTALL=$(kwyzod enum -m "select the tools you wish to uninstall" $(installed $TOOLS))
    if [ "$TOOLS_UNINSTALL" != "" ] && [ "$(kwyzod boolean "UNINSTALL TOOLS\n\n$TOOLS_UNINSTALL")" != "1" ]; then
        exit 1
    fi
fi

if [ "$(not_installed $TOOLS)" != "" ]; then
    TOOLS_INSTALL=$(kwyzod enum -m "select the tools you wish to install" $(not_installed $TOOLS))
    if [ "$TOOLS_INSTALL" != "" ] && [ "$(kwyzod boolean "INSTALL TOOLS\n\n$TOOLS_INSTALL")" != "1" ]; then
        exit 1
    fi
fi

for l in $LANGUAGES_UNINSTALL; do
    echo '$' cody uninstall $l
    cody uninstall $l
done

for t in $TOOLS_UNINSTALL; do
    echo '$' cody uninstall $t
    cody uninstall $t
done

for l in $LANGUAGES_INSTALL; do
    echo '$' cody install $l
    cody install $l
done

for t in $TOOLS_INSTALL; do
    echo '$' cody install $t
    cody install $t
done
