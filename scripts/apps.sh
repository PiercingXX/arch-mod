#!/bin/bash
# GitHub.com/PiercingXX

username=$(id -un)

# Apps to Install
    paru -S fwupd --noconfirm
    paru -S w3m --noconfirm
    paru -Rs firefox --noconfirm
    paru -S dconf --noconfirm
    paru -S fuzzel --noconfirm
    paru -S kitty --noconfirm
    paru -S python --noconfirm
    paru -S npm --noconfirm
    paru -S nautilus-open-any-terminal --noconfirm
    paru -S nautilus-renamer --noconfirm
    paru -S ulauncher --noconfirm
    paru -S vlc --noconfirm
    paru -S ventoy-bin --noconfirm
    paru -S proton-vpn-gtk-app --noconfirm
    flatpak install flathub net.waterfox.waterfox -y
    flatpak install flathub md.obsidian.Obsidian -y
    flatpak install flathub org.libreoffice.LibreOffice -y
    flatpak install flathub org.gnome.SimpleScan -y
    flatpak install flathub org.blender.Blender -y
    flatpak install flathub com.mattjakeman.ExtensionManager -y
    flatpak install flathub org.qbittorrent.qBittorrent -y
    flatpak install flathub io.missioncenter.MissionCenter -y
    flatpak install flathub io.github.shiftey.Desktop -y #Github Desktop
    flatpak install --noninteractive flathub io.github.realmazharhussain.GdmSettings -y
    flatpak install flathub com.flashforge.FlashPrint -y
    flatpak install flathub org.gnome.meld -y # For file comparison
    flatpak install flathub com.nextcloud.desktopclient.nextcloud -y
    flatpak install flathub com.github.xournalpp.xournalpp -y # For PDF annotation

# SSH & Firewall - for arch systems
    sudo pacman -S openssh --noconfirm
    sudo systemctl enable --now sshd
    paru -S ufw --noconfirm
    sudo ufw enable
    sudo ufw allow SSH

# Apps to uninstall
    sudo pacman -Rs gnome-console --noconfirm
    sudo pacman -Rs firefox --noconfirm
    sudo pacman -Rs epiphany --noconfirm
    sudo pacman -Rs gnome-terminal --noconfirm
    sudo pacman -Rs gnome-software --noconfirm
    sudo pacman -Rs software-center --noconfirm
    sudo pacman -Rs dolphin --noconfirm
    sudo pacman -Rs gnome-maps --noconfirm
    sudo pacman -Rs gnome-photos --noconfirm
    sudo pacman -Rs gnome-calendar --noconfirm
    sudo pacman -Rs gnome-contacts --noconfirm
    sudo pacman -Rs gnome-music --noconfirm
    sudo pacman -Rs gnome-text-editor --noconfirm
    sudo pacman -Rs gnome-weather --noconfirm

# Theme stuffs
    paru -S papirus-icon-theme-git --noconfirm

# Gimp
    flatpak install flathub org.gimp.GIMP -y
    flatpak install flathub org.darktable.Darktable -y
    paru -S opencl-amd --noconfirm

# Synology
    paru -S synochat --noconfirm
    paru -S synology-drive --noconfirm
    flatpak install flathub com.synology.synology-note-station -y
    #Synology Drive doesnt support wayland so run this...
    QT_QPA_PLATFORM=xcb

# Yazi
    paru -S yazi-nightly-bin --noconfirm
    paru -S ffmpeg --noconfirm
    paru -S 7zip --noconfirm
    paru -S jq --noconfirm
    paru -S poppler --noconfirm
    paru -S fd --noconfirm
    paru -S ripgrep --noconfirm
    paru -S fzf --noconfirm
    paru -S zoxide --noconfirm
    paru -S resvg --noconfirm
    paru -S imagemagick --noconfirm
    ya pkg add dedukun/bookmarks
    ya pkg add yazi-rs/plugins:mount
    ya pkg add dedukun/relative-motions
    ya pkg add yazi-rs/plugins:chmod
    ya pkg add yazi-rs/plugins:smart-enter
    ya pkg add AnirudhG07/rich-preview
    ya pkg add grappas/wl-clipboard
    ya pkg add Rolv-Apneseth/starship
    ya pkg add yazi-rs/plugins:full-border
    ya pkg add uhs-robert/recycle-bin
    ya pkg add yazi-rs/plugins:diff

# Nvim & Depends
    paru -Rs neovim --noconfirm 2>/dev/null || true
    paru -S neovim-nightly-bin --noconfirm
    sudo pacman -S nodejs npm --noconfirm
    sudo pacman -S ripgrep --noconfirm
    paru -S lua51 --noconfirm
    paru -S python --noconfirm
    paru -S python-pip --noconfirm
    paru -S python-pynvim --noconfirm
    python3 -m pip install --user --upgrade pynvim
    sudo pacman -S chafa --noconfirm
    sudo pacman -S ripgrep --noconfirm

# VScode - Install with necessary dependencies
    echo "Installing VSCode and dependencies..."
    sudo pacman -S xclip xsel --noconfirm  # Clipboard support
    paru -S visual-studio-code-bin --noconfirm
    # Verify installation
    if ! command -v code &> /dev/null; then
        echo "VSCode installation failed. Trying alternative installation..."
        flatpak install flathub com.visualstudio.code -y || echo "Fallback: Failed to install VSCode"
    fi

# Blender
    flatpak install flathub org.blender.Blender -y

# Kdenlive
    flatpak install flathub org.kde.kdenlive -y

# Vial
    paru -S vial-appimage --noconfirm
    # Allows user to access keyboard 
    sudo usermod -aG uucp $USER

# Steam and Gaming
    sudo pacman -S steam --noconfirm
    # Steam Needs Vulkan and 32-bit libs for Proton games
        sudo pacman -S vulkan-tools --noconfirm
        sudo pacman -S vulkan-icd-loader --noconfirm
        sudo pacman -S lib32-vulkan-icd-loader --noconfirm
        sudo pacman -S mesa lib32-mesa --noconfirm
        sudo pacman -S mesa-demos --noconfirm
        sudo pacman -S vulkan-radeon lib32-vulkan-radeon --noconfirm 
        sudo pacman -S lib32-gcc-libs --noconfirm 
        sudo pacman -S lib32-glibc --noconfirm 
        sudo pacman -S lib32-libdrm --noconfirm 
        sudo pacman -S lib32-libx11 --noconfirm 
        sudo pacman -S lib32-libxext --noconfirm 
        sudo pacman -S lib32-libxcomposite --noconfirm 
        sudo pacman -S lib32-libxrender --noconfirm 
        sudo pacman -S lib32-libxfixes --noconfirm 
        sudo pacman -S ib32-libxrandr --noconfirm 
        sudo pacman -S lib32-libxtst --noconfirm 
        sudo pacman -S lib32-libpulse --noconfirm
        sudo pacman -S lib32-openssl --noconfirm
        sudo pacman -S lib32-sdl2 --noconfirm 
    # If NVIDIA proprietary driver is present, install its 32-bit runtime pieces
        if lspci -nn | grep -qi 'NVIDIA'; then
            echo "[*] NVIDIA GPU detected; installing NVIDIA Vulkan runtime components..."
            sudo pacman -S --needed --noconfirm nvidia nvidia-utils lib32-nvidia-utils
        fi
    flatpak install flathub com.discordapp.Discord -y
    paru -S input-remapper --noconfirm

# Ollama
    curl -fsSL https://ollama.com/install.sh | sh
    #ollama pull gpt-oss:20b
    #ollama pull codellama:34b 
    #ollama pull mistral:7b 
    #ollama pull gemma3:27b-it-qat
    #ollama pull gemma3:12b

# Tailscale
    paru -S tailscale --noconfirm
    curl -fsSL https://tailscale.com/install.sh | sh
    wait

# Docker
    paru -S docker docker-compose --noconfirm
    sudo systemctl enable --now docker
    sudo usermod -aG docker $username

# ClamAV
    paru -S clamav --noconfirm
    sudo systemctl enable --now clamav-freshclam
    sudo systemctl enable --now clamav-daemon
    sudo freshclam

# OpenWebUi
#    docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
