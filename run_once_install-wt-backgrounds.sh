#!/bin/bash
# Copy Windows Terminal background images to the RoamingState directory

WT_ROAMING="$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/RoamingState"
SOURCE_DIR="$(chezmoi source-path)/wt-backgrounds"

if [ -d "$(cygpath "$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe")" ]; then
    mkdir -p "$WT_ROAMING"
    cp "$SOURCE_DIR"/*.jpg "$SOURCE_DIR"/*.png "$WT_ROAMING/" 2>/dev/null
    echo "Installed Windows Terminal background images"
else
    echo "Windows Terminal not found, skipping background images"
fi
