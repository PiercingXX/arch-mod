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
        sudo pacman -S base-devel gcc cmake meson --noconfirm
        sudo pacman -S git make pkg-config --noconfirm
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
        if ! command -v paru &> /dev/null; then
            PARU_BUILD_DIR=$(mktemp -d)
            git clone https://aur.archlinux.org/paru-bin.git "$PARU_BUILD_DIR/paru-bin"
            if [ -d "$PARU_BUILD_DIR/paru-bin" ]; then
                cd "$PARU_BUILD_DIR/paru-bin" || exit
                makepkg -si --noconfirm
                PARU_INSTALL_STATUS=$?
                cd "$builddir" || exit
                rm -rf "$PARU_BUILD_DIR"
                if [ $PARU_INSTALL_STATUS -eq 0 ]; then
                    echo "Paru installed successfully!"
                else
                    echo "ERROR: Paru installation failed! Please install manually."
                    exit 1
                fi
            else
                echo "ERROR: Failed to clone paru repository."
                exit 1
            fi
        else
            echo "Paru already installed"
        fi
        # Add Flatpak
        echo "# Installing Flatpak..."
        sudo pacman -S flatpak --noconfirm
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# Installing more Depends
        echo "# Installing more dependencies..."
        paru -S dconf --noconfirm
        paru -S cpio --noconfirm
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
    
# Apply Icon Theme
    echo -e "${YELLOW}Applying Papirus Icon Theme...${NC}"
    dconf write /org/gnome/desktop/interface/icon-theme "'Papirus'"
    gsettings set org.gnome.desktop.interface icon-theme "Papirus"
    echo -e "${GREEN}Icon theme applied!${NC}"

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
        SUPERKEY_BUILD_DIR=$(mktemp -d)
        git clone https://github.com/Tommimon/super-key.git "$SUPERKEY_BUILD_DIR/super-key"
        if [ -d "$SUPERKEY_BUILD_DIR/super-key" ]; then
            cd "$SUPERKEY_BUILD_DIR/super-key" || exit
            if [ -f "build.sh" ]; then
                chmod +x ./build.sh
                ./build.sh -i
                SUPERKEY_BUILD_STATUS=$?
            else
                SUPERKEY_BUILD_STATUS=1
            fi
            if [ $SUPERKEY_BUILD_STATUS -eq 0 ]; then
                EXT_DIR="$HOME/.local/share/gnome-shell/extensions"
                EXT_ID="super-key@tommimon"
                mkdir -p "$EXT_DIR"
                # Find and copy the built extension
                if [ -d "$EXT_ID" ]; then
                    cp -r "$EXT_ID" "$EXT_DIR/"
                    echo "Super-key extension installed successfully"
                else
                    echo "Warning: Super-key extension build directory not found"
                fi
            else
                echo "Warning: Super-key build failed, skipping extension installation"
            fi
            cd "$builddir" || exit
            rm -rf "$SUPERKEY_BUILD_DIR"
        else
            echo "Warning: Failed to clone super-key repository"
        fi
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
