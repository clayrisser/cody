#!/bin/sh

LANGUAGES="
cpp
golang
java
javascript
php
python
ruby
rust
solidity
terraform
"

TOOLS="
android-studio
aws
dbgate
debian
docker
kube
nixos
shell
"

export DEBIAN_FRONTEND=${DEBIAN_FRONTEND:-gnome}
export _TMP_PATH="${XDG_RUNTIME_DIR:-$([ -d "/run/user/$(id -u $USER)" ] && echo "/run/user/$(id -u $USER)" || echo ${TMP:-${TEMP:-/tmp}})}/cody/wizard/$$"

sudo true
mkdir -p $_TMP_PATH

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

true > $_TMP_PATH/cody.templates
if [ "$(installed $LANGUAGES)" != "" ]; then
    cat <<EOF >> $_TMP_PATH/cody.templates
Template: cody/languages_uninstall
Type: multiselect
Description: uninstall languages
 select the languages you wish to uninstall
Choices:$(echo $(installed $LANGUAGES) | sed 's| \+|, |g')

EOF
fi
if [ "$(not_installed $LANGUAGES)" != "" ]; then
    cat <<EOF >> $_TMP_PATH/cody.templates
Template: cody/languages_install
Type: multiselect
Description: install languages
 select the languages you wish to install
Choices:$(echo $(not_installed $LANGUAGES) | sed 's| \+|, |g')

EOF
fi
prompt $_TMP_PATH/cody.templates
RESPONSE=$(response $_TMP_PATH/cody.templates)
LANGUAGES_INSTALL=$(echo "$RESPONSE" | grep '^cody/languages_install:' | sed 's|^cody/languages_install:||g' | sed 's|,| |g')
LANGUAGES_UNINSTALL=$(echo "$RESPONSE" | grep '^cody/languages_uninstall:' | sed 's|^cody/languages_uninstall:||g' | sed 's|,| |g')

true > $_TMP_PATH/cody.templates
if [ "$(installed $TOOLS)" != "" ]; then
    cat <<EOF >> $_TMP_PATH/cody.templates
Template: cody/tools_uninstall
Type: multiselect
Description: uninstall tools
 select the tools you wish to uninstall
Choices:$(echo $(installed $TOOLS) | sed 's| \+|, |g')

EOF
fi
if [ "$(not_installed $TOOLS)" != "" ]; then
    cat <<EOF >> $_TMP_PATH/cody.templates
Template: cody/tools_install
Type: multiselect
Description: install tools
 select the tools you wish to install
Choices:$(echo $(not_installed $TOOLS) | sed 's| \+|, |g')

EOF
fi
prompt $_TMP_PATH/cody.templates
RESPONSE=$(response $_TMP_PATH/cody.templates)
TOOLS_INSTALL=$(echo "$RESPONSE" | grep '^cody/tools_install:' | sed 's|^cody/tools_install:||g' | sed 's|,| |g')
TOOLS_UNINSTALL=$(echo "$RESPONSE" | grep '^cody/tools_uninstall:' | sed 's|^cody/tools_uninstall:||g' | sed 's|,| |g')

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

rm -rf $_TMP_PATH
