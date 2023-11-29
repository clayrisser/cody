#!/bin/bash

VERSION="0.10.4"
APP_IMAGE_DOWNLOAD_PATH="https://dl.todesktop.com/230313mzl4w4u92/linux/appImage/x64"
ICON_DOWNLOAD_PATH="https://www.cursor.so/brand/icon.svg"
APPLICATIONS_PATH="$HOME/Applications"
APP_IMAGE_PATH="$APPLICATIONS_PATH/cursor.AppImage"
ICON_PATH="$HOME/.local/share/icons/cursor-icon.svg"
DESKTOP_FILE_PATH="$HOME/.local/share/applications/cursor.desktop"
EXEC_PATH="$APPLICATIONS_PATH/cursor/cursor"
sudo true
mkdir -p "$APPLICATIONS_PATH"
cd "$APPLICATIONS_PATH"
curl -Lo "$APP_IMAGE_PATH" "$APP_IMAGE_DOWNLOAD_PATH"
chmod +x "$APP_IMAGE_PATH"
sudo rm -rf "$APPLICATIONS_PATH/squashfs-root" "$APPLICATIONS_PATH/cursor"
"$APP_IMAGE_PATH" --appimage-extract
mv "$APPLICATIONS_PATH/squashfs-root" "$APPLICATIONS_PATH/cursor"
if [ ! -f "$ICON_PATH" ]; then
    mkdir -p "$(dirname "$ICON_PATH")"
    curl -o "$ICON_PATH" "$ICON_DOWNLOAD_PATH"
fi
echo "[Desktop Entry]
Name=Cursor
Exec=$EXEC_PATH
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupWMClass=Cursor
X-AppImage-name-Version=$VERSION
Comment=Cursor is an AI-first coding environment.
MimeType=x-scheme-handler/cursor;
Categories=Utility;Development
" > "$DESKTOP_FILE_PATH"
chmod +x "$DESKTOP_FILE_PATH"
echo "#!/usr/bin/env bash
export ELECTRON_RUN_AS_NODE=1
exec \"$EXEC_PATH\" \"$APPLICATIONS_PATH/cursor/resources/app/out/cli.js\" --ms-enable-electron-run-as-node \"\$@\"" | \
    sudo tee "/usr/local/bin/code" >/dev/null
sudo chmod +x "/usr/local/bin/code"
