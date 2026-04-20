#!/usr/bin/env bash
set -uo pipefail

# Verify we are running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

echo "Updating system and installing Nvidia drivers and CUDA..."

# Update the system
pacman -Syu --noconfirm

# Install Nvidia driver stack, CUDA toolkit, and 32‑bit libraries for Steam
pacman -S --noconfirm \
    nvidia \
    nvidia-utils \
    nvidia-settings \
    nvidia-dkms \
    cuda \
    lib32-nvidia-libgl \
    lib32-nvidia-utils

echo "Rebooting to apply changes..."
reboot