#!/bin/bash

# Check for AppImage path argument
if [ -z "$1" ]; then
    echo "Usage: $0 <AppImage path> [-i icon path] [-r new name]"
    exit 1
fi

APPIMAGE_PATH="$1"
ICON_PATH=""
RENAME=""
DEST_DIR="$HOME/.local/share/AppImage"

# Shift to start parsing options
shift

# Parse options
while getopts "i:r:" opt; do
    case $opt in
        i) ICON_PATH="$OPTARG" ;;
        r) RENAME="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
done

# Determine final name for the AppImage file
APP_NAME="${RENAME:-$(basename "$APPIMAGE_PATH")}"
ICON_DEST_DIR="$HOME/.local/share/icons/$APP_NAME"
DEST_APPIMAGE_PATH="$DEST_DIR/$APP_NAME"

# Copy the AppImage to the destination directory
mkdir -p "$DEST_DIR"
cp "$APPIMAGE_PATH" "$DEST_APPIMAGE_PATH"
echo "AppImage copied to $DEST_APPIMAGE_PATH"

# Copy the icon to ~/.local/share/icons/ if provided
if [ -n "$ICON_PATH" ]; then
    mkdir -p "$ICON_DEST_DIR"
    ICON_DEST_PATH="$ICON_DEST_DIR/$(basename "$ICON_PATH")"
    cp "$ICON_PATH" "$ICON_DEST_PATH"
    echo "Icon copied to $ICON_DEST_PATH"
else
    ICON_DEST_PATH=""  # Leave blank if no icon provided
fi

# Create the .desktop entry
DESKTOP_FILE_PATH="$HOME/.local/share/applications/$APP_NAME.desktop"
echo "Creating .desktop file at $DESKTOP_FILE_PATH"

# Start the .desktop entry
{
    echo "[Desktop Entry]"
    echo "Name=$APP_NAME"
    echo "Exec=$DEST_APPIMAGE_PATH"
    
    # Check if ICON_DEST_PATH is not empty before adding it
    if [ -n "$ICON_DEST_PATH" ]; then
        echo "Icon=$ICON_DEST_PATH"
    fi

    echo "Type=Application"
    echo "Categories=Utility;"
    echo "Terminal=false"
} > "$DESKTOP_FILE_PATH"

chmod +x "$DEST_APPIMAGE_PATH"
chmod +x "$DESKTOP_FILE_PATH"
update-desktop-database ~/.local/share/applications
echo "$APP_NAME has been added to the application menu."
