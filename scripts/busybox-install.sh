#!/bin/bash
# GitHub.com/PiercingXX

set -e

PKGMGR="paru -S --noconfirm --needed"

echo "Installing BusyBox core..."
${PKGMGR} busybox busybox-suid

echo "Installing shell and core utilities..."
${PKGMGR} bash coreutils findutils gawk grep sed tar gzip unzip xz

echo "Installing Hypr-like desktop tooling (Wayland + X11 fallback)..."
${PKGMGR} \
  kitty yazi nautilus \
  waybar wlogout nwg-look \
  wl-clipboard cliphist hyprshot grim slurp \
  pavucontrol playerctl cava \
  networkmanager network-manager-applet bluez bluez-utils bluetuith \
  libnotify swaync polkit-gnome \
  brightnessctl light \
  rofi xclip picom polybar feh flameshot

echo "Installing portal/session helpers..."
${PKGMGR} xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland seatd

echo "BusyBox Hypr-like dependency profile installed successfully!"
