#!/bin/sh

export REPO=https://gitlab.com/risserlabs/community/kisspm.git

main() {
  if [ "$INSTALL" = "1" ]; then
    echo "installing $PACKAGE..."
    prepare
    install $PACKAGE
    echo "installed $PACKAGE :)"
  elif [ "$UNINSTALL" = "1" ]; then
    echo "uninstalling $PACKAGE..."
    prepare
    uninstall $PACKAGE
    echo "uninstalled $PACKAGE :)"
  fi
}

install() {
  export PACKAGE=$1
  (cd $HOME/.kisspm && TARGET=install make -s $PACKAGE)
}

uninstall() {
  export PACKAGE=$1
  (cd $HOME/.kisspm && TARGET=uninstall make -s $PACKAGE)
}

prepare() {
  if [ ! -d $HOME/.kisspm ]; then
    git clone $REPO $HOME/.kisspm
  else
    (cd $HOME/.kisspm && git pull origin main >/dev/null 2>/dev/null || true)
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
      echo "kisspm [options] application [arguments]"
      echo " "
      echo "options:"
      echo "-h, --help                show brief help"
      echo "-i, --install=PACKAGE       specify an action to use"
      echo "-u, --uninstall=PACKAGE      specify a directory to store output in"
      exit 0
      ;;
    -i|--install)
      shift
      if test $# -gt 0; then
        unset UNINSTALL
        export INSTALL=1
        export PACKAGE=$1
      else
        echo "no package specified"
        exit 1
      fi
      shift
      ;;
    -u|--uninstall)
      shift
      if test $# -gt 0; then
        unset INSTALL
        export UNINSTALL=1
        export PACKAGE=$1
      else
        echo "no package specified"
        exit 1
      fi
      shift
      ;;
    *)
      break
      ;;
  esac
done

main
