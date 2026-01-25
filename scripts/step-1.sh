#!/bin/bash
# GitHub.com/PiercingXX

username=$(id -un)
builddir=$(pwd)


# Create Directories if needed
    echo -e "${YELLOW}Creating Necessary Directories...${NC}"
        # font directory
            if [ ! -d "$HOME/.fonts" ]; then
                mkdir -p "$HOME/.fonts"
            fi
            chown -R "$username":"$username" "$HOME"/.fonts
        # icons directory
            if [ ! -d "$HOME/.icons" ]; then
                mkdir -p /home/"$username"/.icons
            fi
            chown -R "$username":"$username" /home/"$username"/.icons
        # Background and Profile Image Directories
            if [ ! -d "$HOME/$username/Pictures/backgrounds" ]; then
                mkdir -p /home/"$username"/Pictures/backgrounds
            fi
            chown -R "$username":"$username" /home/"$username"/Pictures/backgrounds
            if [ ! -d "$HOME/$username/Pictures/profile-image" ]; then
                mkdir -p /home/"$username"/Pictures/profile-image
            fi
            chown -R "$username":"$username" /home/"$username"/Pictures/profile-image
        # fstab external drive mounting directory
            if [ ! -d "/media/Working-Storage" ]; then
                sudo mkdir -p /media/Working-Storage
                sudo chown "$username":"$username" /media/Working-Storage
            fi
            if [ ! -d "/media/Archived-Storage" ]; then
                sudo mkdir -p /media/Archived-Storage
                sudo chown "$username":"$username" /media/Archived-Storage
            fi
# System Update
        sudo pacman -Syu --noconfirm

# Install dependencies
        echo "# Installing dependencies..."
        sudo pacman -S trash-cli --noconfirm
        sudo pacman -S fastfetch --noconfirm
        sudo pacman -S tree --noconfirm
        sudo pacman -S zoxide --noconfirm
        sudo pacman -S bash-completion --noconfirm
        sudo pacman -S starship --noconfirm
        sudo pacman -S eza --noconfirm
        sudo pacman -S bat --noconfirm
        sudo pacman -S fzf --noconfirm
        sudo pacman -S trash-cli --noconfirm
        sudo pacman -S chafa --noconfirm
        sudo pacman -S w3m --noconfirm
        sudo pacman -S reflector --noconfirm
        sudo pacman -S zip unzip gzip tar make wget tar fontconfig --noconfirm
        sudo pacman -Syu linux-firmware --noconfirm
        sudo pacman -S bc brightnessctl dunst --noconfirm        
        sudo pacman -S tmux --noconfirm
        sudo pacman -S sshpass --noconfirm
        sudo pacman -S htop --noconfirm
        sudo pacman -S glm --noconfirm
        paru -S nvtop-git --noconfirm
        paru -S lnav --noconfirm
# Ensure Pipewire for audio
    sudo pacman -S pipewire wireplumber pipewire-pulse pipewire-alsa --noconfirm
    sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav --noconfirm
    systemctl --user restart pipewire pipewire-pulse wireplumber

# Add Paru, Flatpak, & Dependencies if needed
    echo -e "${YELLOW}Installing Paru, Flatpak, & Dependencies...${NC}"
        # Clone and install Paru
        echo "# Cloning and installing Paru..."
        git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si --noconfirm && cd ..
        # Add Flatpak
        echo "# Installing Flatpak..."
        sudo pacman -S flatpak --noconfirm
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# Installing more Depends
        echo "# Installing more dependencies..."
        paru -S dconf --noconfirm
        paru -S cpio cmake meson --noconfirm
        paru -S wmctrl xdotool libinput-gestures --noconfirm
        paru -S multitail jump-bin --noconfirm

# System Control Services
    echo "# Enabling Bluetooth and Printer services..."
    # Enable Bluetooth
        sudo systemctl start bluetooth
        sudo systemctl enable bluetooth
    # Enable Printer 
        sudo pacman -S cups gutenprint cups-pdf gtk3-print-backends nmap net-tools cmake meson cpio --noconfirm
        sudo systemctl enable cups.service
        sudo systemctl start cups
    # Printer Drivers
        paru -S cnijfilter2-mg3600 --noconfirm #Canon mg3600 driver
        #paru -S cndrvcups-lb --noconfirm # Canon D530 driver
    # Add dialout to edit ZMK and VIA Keyboards
        sudo usermod -aG uucp $USER

# Theme stuffs
    paru -S papirus-icon-theme-git --noconfirm

# Install fonts
    echo "Installing Fonts"
    cd "$builddir" || exit
    sudo pacman -S ttf-firacode-nerd --noconfirm
    paru -S ttf-nerd-fonts-symbols --noconfirm
    paru -S noto-fonts-emoji-colrv1 --noconfirm
    sudo pacman -S ttf-jetbrains-mono-nerd --noconfirm
    paru -S awesome-terminal-fonts-patched --noconfirm
    paru -S ttf-ms-fonts --noconfirm
    paru -S terminus-font-ttf --noconfirm
    paru -S wtype-git --noconfirm
    paru -S xcursor-simp1e-gruvbox-light --noconfirm
    # Reload Font
    fc-cache -vf
    wait

# Extensions Install
    echo -e "${YELLOW}Installing Gnome Extensions...${NC}"
    paru -S libayatana-appindicator-glib --noconfirm
    paru -S gnome-shell-extension-blur-my-shell-git --noconfirm
    paru -S gnome-shell-extension-just-perfection-desktop --noconfirm
    paru -S gnome-shell-extension-pop-shell-git --noconfirm
    paru -S gnome-shell-extension-gsconnect --noconfirm
    paru -S nautilus-open-any-terminal --noconfirm
    # Workspaces Buttons with App Icons
        curl -L https://codeload.github.com/Favo02/workspaces-by-open-apps/zip/refs/heads/main -o workspaces.zip
        unzip workspaces.zip -d workspaces-by-open-apps-main
        chmod -R u+x workspaces-by-open-apps-main
        cd workspaces-by-open-apps-main/workspaces-by-open-apps-main || exit
        sudo ./install.sh local-install
        cd "$builddir" || exit
        rm -rf workspaces-by-open-apps-main
    # Super Key
        echo -e "${YELLOW}Installing Super‑Key extension...${NC}"
        git clone https://github.com/Tommimon/super-key.git
        cd super-key || exit
        ./build.sh -i
        EXT_BUILD_DIR="$builddir/super-key"
            if [ ! -d "$EXT_BUILD_DIR" ]; then
                echo "Build output not found in $EXT_BUILD_DIR"
                exit 1
            fi
        EXT_DIR="$HOME/.local/share/gnome-shell/extensions"
        EXT_ID="super-key@tommimon"   # <-- adjust if the folder name differs
        mkdir -p "$EXT_DIR"
        cp -r "$EXT_BUILD_DIR" "$EXT_DIR/$EXT_ID"
        cd "$builddir" || exit
        rm -rf super-key
    echo -e "${GREEN}Gnome Extensions Installed Successfully!${NC}"

# Apply Piercing Rice
    echo -e "${YELLOW}Applying PiercingXX Gnome Customizations...${NC}"
        rm -rf piercing-dots
        git clone --depth 1 https://github.com/Piercingxx/piercing-dots.git
        cd piercing-dots || exit
        chmod u+x install.sh
        ./install.sh
        cd "$builddir" || exit
        rm -rf piercing-dots
