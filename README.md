# Screenshot Toolkit for Hyprland

A complete screenshot management system for Hyprland with automatic window naming, Steam game detection, and interactive notifications.

<p align="center">
  <video src="https://github.com/walkiewho/Hyprland-screenshots/raw/main/assets/usage.webm" 
         controls 
         width="800" 
         height="450" 
         autoplay 
         loop 
         muted>
    Ваш браузер не поддерживает видео.
  </video>
</p>

## Features
- Full screen, area, and active window screenshots
- Automatic window naming from .desktop files
- Steam game detection with custom name mapping
- Interactive notifications with actions (Show, Open, Delete)
- Screenshots copied to clipboard automatically
- Sound feedback on capture
- Symlinks for quick access

---

## Dependencies

### Required
- `hyprctl` – Hyprland control utility
- `grim` – Screenshot utility for Wayland
- `slurp` – Area selection for Wayland
- `jq` – JSON processor
- `wl-copy` – Wayland clipboard utility
- `notify-send` – Desktop notifications
- `pw-play` – Sound playback (PipeWire)

### Optional
- `xdg-utils` – For opening files/folders
- `find` – For symlink management

### Installation on Arch
```bash
sudo pacman -S grim slurp jq wl-clipboard libnotify pipewire xdg-utils
```
### Installation on Ubuntu/Debian
```bash
sudo apt install grim slurp jq wl-clipboard libnotify-bin pipewire xdg-utils
```

---

## Installation
```bash
https://github.com/walkiewho/Hyprland-screenshots
cd Hyprland-screenshots
chmod +x setup.sh
./setup.sh
```
The setup script will:
  - Make all scripts executable
  - Copy scripts to ~/.local/scripts/
  - Copy configuration files to ~/.config/

---

## Usage
### Basic commands
Fullscreen screenshot
```bash
~/.local/scripts/take-full-screenshot 
```
Area screenshot (with slurp)
```bash
~/.local/scripts/take-area-screenshot 
```
Window screenshot (with hyprctl and slurp connecting to windows)
```bash
~/.local/scripts/take-window-screenshot 
```
Also you can use main script with your own props
```bash
~/.local/scripts/take-size_screenshot "100,100 800x600"
```

### Configutation files
`~/.config/steam_apps.txt` - a complete file with `app_id=app_name` for every application in steam in 2025
If there is no your game you can add it manualy.

Example:
  - 10=Counter-Strike
  - 70=Half-Life
  - 4711740=Mortal Shell II

`~/.config/screenshot_class_map.txt` - your file for custom names for applications. Just add `class_name=pretty_name` to this file and every screenshot will in this application will be with this name.

Example:
  - org.kde.dolphin=Dolphin
  - jetbrains-pycharm-ce=PyCharm
  - Alacritty=Terminal

---

## Hyprland Keybindings
I use this keybindings but you can add yours

Add it to your `~/.config/hypr/hyprland.conf` (or another config file)
```conf
bind = SUPER, Print, exec, ~/.local/scripts/take-full-screenshot # Full screenshot
bind = Super+Shift, S, exec, ~/.local/scripts/take-area-screenshot # Area screenshot
bind = Super+Shift, W, exec, ~/.local/scripts/take-window-screenshot # Window screenshot
```

---

## Customize Slurp Appearance
If you want you can change slurp configuration in `take_area_screenshot` or `take_window_screenshot`

`slurp -d -b \#01010180 -c \#d7bbb5aa` by default.

Options:
  - -d           : Display dimensions
  - -b COLOR     : Background color (border)
  - -c COLOR     : Cursor color
  - -B COLOR     : Background color (inside selection)
  - -C COLOR     : Cursor color (inside selection)
  - -w INT       : Border width

---

## How It Works
1. Window Detection: Uses hyprctl clients and get_windows_by_pos to find the window under cursor
2. Name Resolution:
   - Checks screenshot_class_map.txt for custom mapping
   - Searches .desktop files for localized names
   - Falls back to simplified class name
3. Steam Detection: Identifies steam_app_* windows and maps AppID to game name using steam_apps.txt
4. Screenshot Capture: Uses grim with geometry from slurp
5. File Organization: Saves to ~/Pictures/Screenshots/<app_name>/<yyyy-mm-dd hh\:mm\:ss app_name>.png with timestamp
6. Creates symlink in ~/Pictures/Screenshots/Massive/
7. Clipboard: Copies screenshot to clipboard via wl-copy
8. Notifications: Interactive notification with actions
