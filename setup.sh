#!/bin/bash

chmod +x ./*

SCRIPT_DIR="$HOME/.local/scripts"
CONFIG_DIR="$HOME/.config"
mkdir -p "$SCRIPT_DIR"
mkdir -p "$CONFIG_DIR"


echo "Copying scripts to $SCRIPT_DIR"
cp "get_windows_by_pos" "$SCRIPT_DIR"
cp "take_size_screenshot" "$SCRIPT_DIR"
cp "take_full_screenshot" "$SCRIPT_DIR"
cp "take_area_screenshot" "$SCRIPT_DIR"
cp "take_window_screenshot" "$SCRIPT_DIR"

echo "Copying steam_apps.txt to $CONFIG_DIR"
cp "steam_apps.txt" "$CONFIG_DIR"

echo "Creating new file in $CONFIG_DIR"
touch "$CONFIG_DIR/screenshot_class_map.txt"

./print_help.sh
