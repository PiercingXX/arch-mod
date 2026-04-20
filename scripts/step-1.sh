#!/bin/bash
# GitHub.com/PiercingXX

set -euo pipefail

trap 'echo "# Installer failed at line ${LINENO}: ${BASH_COMMAND}" >&2' ERR

username=$(id -un)
builddir=$(pwd)

# Fallback color definitions (script may be run standalone)
: "${YELLOW:=''}"
: "${GREEN:=''}"
: "${NC:=''}"

configure_pipewire_session() {
    sudo mkdir -p /etc/xdg/autostart

    if [ -f /usr/share/applications/pipewire.desktop ]; then
        sudo ln -snf /usr/share/applications/pipewire.desktop /etc/xdg/autostart/pipewire.desktop
    fi

    if [ -f /usr/share/applications/pipewire-pulse.desktop ]; then
        sudo ln -snf /usr/share/applications/pipewire-pulse.desktop /etc/xdg/autostart/pipewire-pulse.desktop
    fi

    if [ -f /usr/share/applications/wireplumber.desktop ]; then
        sudo ln -snf /usr/share/applications/wireplumber.desktop /etc/xdg/autostart/wireplumber.desktop
    fi
}


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
            if [ ! -d "$HOME/Pictures/backgrounds" ]; then
                mkdir -p /home/"$username"/Pictures/backgrounds
            fi
            chown -R "$username":"$username" /home/"$username"/Pictures/backgrounds
            if [ ! -d "$HOME/Pictures/profile-image" ]; then
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
    sudo pacman -S rust --noconfirm
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
        sudo pacman -S bc brightnessctl --noconfirm        
        sudo pacman -S tmux --noconfirm
        sudo pacman -S sshpass --noconfirm
        sudo pacman -S htop --noconfirm
        sudo pacman -S glm --noconfirm
# Ensure Pipewire for audio
    sudo pacman -S pipewire wireplumber pipewire-pulse pipewire-alsa --noconfirm
    sudo pacman -S gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav --noconfirm
    configure_pipewire_session

# Add Paru, Flatpak, & Dependencies if needed
    echo -e "${YELLOW}Installing Paru, Flatpak, & Dependencies...${NC}"
        # Install Paru
        # Ensure build prerequisites are present and avoid cargo provider prompt under --noconfirm.
        sudo pacman -S --needed --noconfirm git base-devel rust cargo
        git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd ..
        # Packages that require AUR helper
        paru -S nvtop-git --noconfirm
        paru -S lnav --noconfirm
        # Add Flatpak
        echo "# Installing Flatpak..."
        sudo pacman -S flatpak --noconfirm
        sudo flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        sudo flatpak remote-add --system --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

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
    
    # Ensure gnome-shell-extensions package is installed
    sudo pacman -S gnome-shell-extensions --noconfirm

    # AppIndicator and KStatusNotifierItem Support (system tray icons)
    echo -e "${YELLOW}Installing AppIndicator and KStatusNotifierItem Support...${NC}"
    sudo pacman -S --needed --noconfirm gnome-shell-extension-appindicator libappindicator-gtk3 || echo "Warning: appindicator packages install failed"
    paru -S --needed --noconfirm libayatana-appindicator 2>/dev/null || true

    enable_gnome_extension() {
        local uuid="$1"
        if command -v gnome-extensions >/dev/null 2>&1; then
            gnome-extensions enable "$uuid" 2>/dev/null || true
        fi
    }
    
    # Install extensions with error handling
    EXTENSIONS_TO_INSTALL=(
        "gnome-shell-extension-blur-my-shell-git"
        "gnome-shell-extension-just-perfection-desktop"
        "gnome-shell-extension-gsconnect"
    )
    
    for ext in "${EXTENSIONS_TO_INSTALL[@]}"; do
        echo "Installing extension: $ext"
        if paru -S "$ext" --noconfirm 2>/dev/null; then
            echo "✓ $ext installed"
        else
            echo "⚠ Warning: $ext installation failed (may not exist in AUR)"
        fi
    done
    
    # Install pop-shell separately with extra handling
    echo "Installing Pop Shell extension..."
    paru -S --needed gnome-shell-extension-pop-shell --noconfirm 2>/dev/null \
        || paru -S --needed gnome-shell-extension-pop-shell-git --noconfirm 2>/dev/null \
        || paru -S --needed pop-shell --noconfirm 2>/dev/null \
        || echo "⚠ Warning: Pop Shell not available"
    enable_gnome_extension "pop-shell@system76.com"
    
    # Nautilus extension
    paru -S nautilus-open-any-terminal --noconfirm || echo "Warning: nautilus-open-any-terminal install failed"
    
    # Enable extensions via dconf
    echo -e "${YELLOW}Enabling installed extensions...${NC}"
    
    # Set enabled extensions list
    dconf write /org/gnome/shell/enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'just-perfection-desktop@just-perfection', 'gsconnect@andyholmes.github.io', 'pop-shell@system76.com']" 2>/dev/null || true
    enable_gnome_extension "appindicatorsupport@rgcjonas.gmail.com"
    enable_gnome_extension "blur-my-shell@aunetx"
    enable_gnome_extension "just-perfection-desktop@just-perfection"
    enable_gnome_extension "gsconnect@andyholmes.github.io"
    enable_gnome_extension "pop-shell@system76.com"
    
    echo -e "${GREEN}Extensions installation complete!${NC}"
    
    # Workspaces Buttons with App Icons
        echo -e "${YELLOW}Installing Workspaces by Open Apps extension...${NC}"
        WORKSPACES_BUILD_DIR=$(mktemp -d)
        if curl -fsSL https://codeload.github.com/Favo02/workspaces-by-open-apps/zip/refs/heads/main -o "$WORKSPACES_BUILD_DIR/workspaces.zip"; then
            unzip -q "$WORKSPACES_BUILD_DIR/workspaces.zip" -d "$WORKSPACES_BUILD_DIR"

            WORKSPACES_INSTALL_SH=$(find "$WORKSPACES_BUILD_DIR" -maxdepth 4 -type f -name install.sh -print -quit)
            if [ -n "$WORKSPACES_INSTALL_SH" ]; then
                WORKSPACES_SRC_DIR=$(dirname "$WORKSPACES_INSTALL_SH")
                chmod +x "$WORKSPACES_INSTALL_SH"
                (cd "$WORKSPACES_SRC_DIR" && ./install.sh local-install) 2>/dev/null
                if [ $? -eq 0 ]; then
                    echo "✓ Workspaces extension installed"
                    dconf write /org/gnome/shell/enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'just-perfection-desktop@just-perfection', 'gsconnect@andyholmes.github.io', 'pop-shell@system76.com', 'workspaces-by-open-apps@favo02']" 2>/dev/null || true
                    enable_gnome_extension "workspaces-by-open-apps@favo02"
                else
                    echo "⚠ Warning: Workspaces extension installation failed"
                fi
            else
                echo "⚠ Warning: Could not locate install.sh in Workspaces by Open Apps archive"
            fi
            cd "$builddir" || exit
        else
            echo "⚠ Warning: Failed to download Workspaces extension"
        fi
        rm -rf "$WORKSPACES_BUILD_DIR"
        
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
                if [ -d "$EXT_DIR/$EXT_ID" ]; then
                    echo "✓ Super-key extension installed"
                else
                    SUPERKEY_EXT_SRC=$(find . -maxdepth 4 -type d -name "$EXT_ID" -print -quit)
                    if [ -n "$SUPERKEY_EXT_SRC" ]; then
                        rm -rf "$EXT_DIR/$EXT_ID"
                        cp -r "$SUPERKEY_EXT_SRC" "$EXT_DIR/"
                        echo "✓ Super-key extension installed"
                    else
                        echo "⚠ Warning: Super-key extension directory not found after build"
                    fi
                fi
                dconf write /org/gnome/shell/enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com', 'blur-my-shell@aunetx', 'just-perfection-desktop@just-perfection', 'gsconnect@andyholmes.github.io', 'pop-shell@system76.com', 'workspaces-by-open-apps@favo02', 'super-key@tommimon']" 2>/dev/null || true
                enable_gnome_extension "super-key@tommimon"

                # Optional: set Super-key default launcher to Ulauncher (if supported by the extension)
                echo -e "${YELLOW}Configuring Super‑Key to launch Ulauncher (if supported)...${NC}"
                SUPERKEY_SCHEMA=""
                if [ -f "$EXT_DIR/$EXT_ID/metadata.json" ]; then
                    SUPERKEY_SCHEMA=$(sed -n 's/.*"settings-schema"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$EXT_DIR/$EXT_ID/metadata.json" | head -n 1)
                fi
                if [ -z "$SUPERKEY_SCHEMA" ] && command -v gsettings >/dev/null 2>&1; then
                    SUPERKEY_SCHEMA=$(gsettings list-schemas 2>/dev/null | grep -iE 'tommimon|super[- ]?key' | head -n 1)
                fi

                SUPERKEY_SCHEMA_DIR="$EXT_DIR/$EXT_ID/schemas"
                if [ -d "$SUPERKEY_SCHEMA_DIR" ] && command -v glib-compile-schemas >/dev/null 2>&1; then
                    glib-compile-schemas "$SUPERKEY_SCHEMA_DIR" 2>/dev/null || true
                fi

                if [ -n "$SUPERKEY_SCHEMA" ] && command -v gsettings >/dev/null 2>&1; then
                    if [ -d "$SUPERKEY_SCHEMA_DIR" ]; then
                        SUPERKEY_KEYS=$(gsettings --schemadir "$SUPERKEY_SCHEMA_DIR" list-keys "$SUPERKEY_SCHEMA" 2>/dev/null || true)
                    else
                        SUPERKEY_KEYS=$(gsettings list-keys "$SUPERKEY_SCHEMA" 2>/dev/null || true)
                    fi

                    # Try common key names for "launch command" style settings
                    for key in command custom-command launcher; do
                        if echo "$SUPERKEY_KEYS" | grep -qx "$key"; then
                            if [ -d "$SUPERKEY_SCHEMA_DIR" ]; then
                                gsettings --schemadir "$SUPERKEY_SCHEMA_DIR" set "$SUPERKEY_SCHEMA" "$key" "ulauncher-toggle" 2>/dev/null || true
                            else
                                gsettings set "$SUPERKEY_SCHEMA" "$key" "ulauncher-toggle" 2>/dev/null || true
                            fi
                        fi
                    done

                    # Try common key names for "desktop file/app id" style settings
                    for key in application default-application default-app app; do
                        if echo "$SUPERKEY_KEYS" | grep -qx "$key"; then
                            if [ -d "$SUPERKEY_SCHEMA_DIR" ]; then
                                gsettings --schemadir "$SUPERKEY_SCHEMA_DIR" set "$SUPERKEY_SCHEMA" "$key" "ulauncher.desktop" 2>/dev/null || true
                            else
                                gsettings set "$SUPERKEY_SCHEMA" "$key" "ulauncher.desktop" 2>/dev/null || true
                            fi
                        fi
                    done
                else
                    echo "⚠ Warning: Could not determine Super‑Key settings schema; skipping Ulauncher default config"
                fi
            else
                echo "⚠ Warning: Super-key build failed"
            fi
            cd "$builddir" || exit
            rm -rf "$SUPERKEY_BUILD_DIR"
        else
            echo "⚠ Warning: Failed to clone super-key repository"
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
