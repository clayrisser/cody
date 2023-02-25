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

cat <<EOF > $_TMP_PATH/cody.templates
Template: cody/languages_installed
Type: note
Description: installed lanagues
 $(echo $(installed $LANGUAGES) | sed 's|\s|, |g')

Template: cody/languages_install
Type: multiselect
Description: install lanagues
 select the languages you wish to install
Choices:$(echo $(not_installed $LANGUAGES) | sed 's| \+|, |g')
EOF
prompt $_TMP_PATH/cody.templates
RESPONSE=$(response $_TMP_PATH/cody.templates)
LANGUAGES_INSTALL=$(echo "$RESPONSE" | grep '^cody/languages_install:' | sed 's|^cody/languages_install:||g' | sed 's|,| |g')

cat <<EOF > $_TMP_PATH/cody.templates
Template: cody/tools_installed
Type: note
Description: installed tools
 $(echo $(installed $TOOLS) | sed 's|\s|, |g')

Template: cody/tools_install
Type: multiselect
Description: install tools
 select the tools you wish to install
Choices:$(echo $(not_installed $TOOLS) | sed 's| \+|, |g')
EOF
prompt $_TMP_PATH/cody.templates
RESPONSE=$(response $_TMP_PATH/cody.templates)
TOOLS_INSTALL=$(echo "$RESPONSE" | grep '^cody/tools_install:' | sed 's|^cody/tools_install:||g' | sed 's|,| |g')

for l in $LANGUAGES_INSTALL; do
    echo '$' cody install $l
    cody install $l
done

for t in $TOOLS_INSTALL; do
    echo '$' cody install $t
    cody install $t
done

rm -rf $_TMP_PATH
