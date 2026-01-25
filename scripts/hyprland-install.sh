#!/bin/bash
# GitHub.com/PiercingXX

# Set up variables for better readability
PKGMGR="paru -S --noconfirm"

# Install core Hyprland components
${PKGMGR} hyprland-meta-git
${PKGMGR} hyprpaper
${PKGMGR} hyprlock
${PKGMGR} hypridle
${PKGMGR} hyprcursor-git
${PKGMGR} hyprsunset
${PKGMGR} polkit-gnome

# Install additional utilities
${PKGMGR} wlsunset-git
${PKGMGR} wl-clipboard
${PKGMGR} libdbusmenu-gtk3

# Set up Waybar and menus
${PKGMGR} waybar
${PKGMGR} nwg-drawer
${PKGMGR} fuzzel
${PKGMGR} wlogout
${PKGMGR} libnotify
${PKGMGR} notification-daemon
${PKGMGR} swaync

# Install file manager and customization tools
${PKGMGR} nautilus
${PKGMGR} nautilus-renamer
${PKGMGR} nautilus-open-any-terminal
${PKGMGR} code-nautilus-git

# Add screenshot and clipboard utilities
${PKGMGR} hyprshot
${PKGMGR} wl-gammarelay
${PKGMGR} brightnessctl
${PKGMGR} light
${PKGMGR} cliphist

# Install audio tools
${PKGMGR} pamixer
${PKGMGR} cava
${PKGMGR} wireplumber
${PKGMGR} playerctl
${PKGMGR} pavucontrol

# Network and Bluetooth utilities
${PKGMGR} networkmanager
${PKGMGR} network-manager-applet
${PKGMGR} bluetuith
${PKGMGR} bluez
${PKGMGR} bluez-utils

# GUI customization tools
${PKGMGR} nwg-look

#Gnome customization tool
${PKGMGR} dconf

#Monitor locator
${PKGMGR} nwg-displays


# Additional Hyprland plugins and configurations
hyprpm update
hyprpm reload
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
hyprpm enable dynamic-cursors
hyprpm add https://github.com/horriblename/hyprgrass
hyprpm enable hyprgrass

# Success message
echo -e "\nAll packages installed successfully!"
