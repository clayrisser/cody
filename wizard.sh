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
if ! which easybashgui >/dev/null 2>/dev/null; then
    cody install easybashgui
fi
source easybashgui

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

message "select the languages you wish to uninstall"
list $(installed $LANGUAGES)
LANGUAGES_UNINSTALL="$(0< "$dir_tmp/$file_tmp" )"
message "UNINSTALLING LANGUAGES

$LANGUAGES_UNINSTALL"

message "select the languages you wish to install"
list $(not_installed $LANGUAGES)
LANGUAGES_INSTALL="$(0< "$dir_tmp/$file_tmp" )"
message "INSTALLING LANGUAGES

$LANGUAGES_INSTALL"

message "select the tools you wish to uninstall"
list $(installed $TOOLS)
TOOLS_UNINSTALL="$(0< "$dir_tmp/$file_tmp" )"
message "UNINSTALLING TOOLS

$TOOLS_UNINSTALL"

message "select the languages you wish to install"
list $(not_installed $TOOLS)
TOOLS_INSTALL="$(0< "$dir_tmp/$file_tmp" )"
message "INSTALLING TOOLS

$TOOLS_INSTALL"

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
