#!/bin/sh

export DEBIAN_FRONTEND=${DEBIAN_FRONTEND:-gnome}
export _TMP_PATH="${XDG_RUNTIME_DIR:-$([ -d "/run/user/$(id -u $USER)" ] && echo "/run/user/$(id -u $USER)" || echo ${TMP:-${TEMP:-/tmp}})}/cody/wizard/$$"

sudo true
mkdir -p $_TMP_PATH

cat <<EOF > $_TMP_PATH/cody.templates
Template: cody/languages
Type: multiselect
Description: install lanagues
 select the languages you wish to install
Choices:javascript, python, rust, ruby, solidity, terraform, golang, java, php, cpp
Default:javascript, python
EOF

prompt /tmp/cody.templates
RESPONSE=$(response /tmp/cody.templates)

LANAGUES=$(echo "$RESPONSE" | grep '^cody/languages:' | sed 's|^cody/languages:||g' | sed 's|,| |g')

for l in $LANAGUES; do
    cody install $l
done

rm -rf $_TMP_PATH
