#!/bin/bash

VERSION="2.1.1"
APP_IMAGE_DOWNLOAD_PATH="https://github.com/saturneric/GpgFrontend/releases/download/v${VERSION}/GpgFrontend-${VERSION}-linux-x86_64.AppImage"
ICON_DOWNLOAD_PATH="https://camo.githubusercontent.com/9f1ac8b3dbec5408450d2ed3b0cad12a6084d02c9825e2f19d2a025d2f1cb122/68747470733a2f2f696d6167652e63646e2e626b7475732e636f6d2f692f323032332f31312f31362f38653634656361622d343334662d386333662d393031632d3262623233333964346262372e77656270"
APPLICATIONS_PATH="$HOME/Applications"
APP_IMAGE_PATH="$APPLICATIONS_PATH/GpgFrontend.AppImage"
DESKTOP_FILE_PATH="$HOME/.local/share/applications/gpgfrontend.desktop"
ICON_PATH="$HOME/.local/share/icons/gpgfrontend-icon.png"
EXEC_PATH="xrun $APP_IMAGE_PATH"
mkdir -p "$APPLICATIONS_PATH"
cd "$APPLICATIONS_PATH"
curl -Lo "$APP_IMAGE_PATH" "$APP_IMAGE_DOWNLOAD_PATH"
chmod +x "$APP_IMAGE_PATH"
if [ ! -f "$ICON_PATH" ]; then
    mkdir -p "$(dirname "$ICON_PATH")"
    curl -o "$ICON_PATH" "$ICON_DOWNLOAD_PATH"
fi
echo "[Desktop Entry]
Name=GpgFrontend
Exec=$EXEC_PATH
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupWMClass=GpgFrontend
X-AppImage-name-Version=$VERSION
Comment=Cursor is an AI-first coding environment.
Categories=Utility
" > "$DESKTOP_FILE_PATH"
chmod +x "$DESKTOP_FILE_PATH"
