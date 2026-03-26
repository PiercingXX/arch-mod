#!/bin/bash
# GitHub.com/PiercingXX

set -euo pipefail

PKGMGR=(paru -S --noconfirm --needed)

install_group() {
  local label="$1"
  shift

  echo "$label..."
  "${PKGMGR[@]}" "$@"
}

echo "Installing BusyBox X11 profile prerequisites..."

install_group "Installing BusyBox userspace" \
  busybox busybox-suid bash

install_group "Installing bspwm session components" \
  bspwm sxhkd polybar picom \
  xorg-server xorg-xrandr xorg-xsetroot xorg-setxkbmap xorg-xrdb xorg-xinput numlockx

install_group "Installing terminal and file tools" \
  kitty tmux yazi nautilus

install_group "Installing launcher, clipboard, screenshot, and wallpaper tools" \
  rofi xclip flameshot hsetroot jq

install_group "Installing audio, notification, and brightness tools" \
  pipewire pipewire-pulse wireplumber \
  pavucontrol playerctl libnotify brightnessctl light cava

install_group "Installing network, auth, input, and bluetooth helpers" \
  networkmanager network-manager-applet polkit-gnome \
  fcitx5 bluez bluez-utils bluetuith

install_group "Installing lock screen support" \
  i3lock

echo
echo "BusyBox X11 profile installed successfully."
echo "This profile is intentionally X11+bspwm focused and assumes piercing-dots"
echo "has already populated your shared configs and ~/.scripts during the main install."
