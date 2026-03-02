#!/bin/bash
# GitHub.com/PiercingXX

# Color definitions
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

# Check/install gum if missing
if ! command -v gum &> /dev/null; then
    echo "gum not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm gum
    else
        echo "Please install gum manually."
        exit 1
    fi
fi

# Check if running as root. If root, script will exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be executed as root! Exiting......."
    exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to cache sudo credentials
cache_sudo_credentials() {
    echo "Caching sudo credentials for script execution..."
    sudo -v
    # Keep sudo credentials fresh for the duration of the script
    (while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &)
}

# Function to install bashrc support (placeholder - extend as needed)
install_bashrc_support() {
    # This function ensures bashrc configurations are properly loaded
    # Add any bashrc initialization logic here
    return 0
}

# Check for active network connection
if command_exists nmcli; then
    state=$(nmcli -t -f STATE g)
    if [[ "$state" != connected ]]; then
        echo "Network connectivity is required to continue."
        exit 1
    fi
else
    # Fallback: ensure at least one interface has an IPv4 address
    if ! ip -4 addr show | grep -q "inet "; then
        echo "Network connectivity is required to continue."
        exit 1
    fi
fi

# Additional ping test to confirm internet reachability
if ! ping -c 1 -W 1 8.8.8.8 >/dev/null 2>&1; then
    echo "Network connectivity is required to continue."
    exit 1
fi




username=$(id -un)
builddir=$(pwd)

# Cache sudo credentials
cache_sudo_credentials

# Function to display a message box using gum
function msg_box() {
    gum style --border double --margin "1 2" --padding "1 2" --foreground 212 "$1"
    read -n 1 -s -r -p "Press any key to continue..."; echo
}

# Function to display menu using gum
function menu() {
    local options=(
        "Install Arch Mod"
        "Optional Nvidia Drivers"
        "Optional Surface Kernel"
        "Reboot System"
        "Exit"
    )
    printf "%s\n" "${options[@]}" | gum choose --header "Run Options In Order:" --cursor.foreground 212 --selected.foreground 212
}
# Main menu loop
while true; do
    clear
    echo -e "${BLUE}PiercingXX's Arch Mod Script${NC}"
    echo -e "${GREEN}Welcome ${username}${NC}\n"
    choice=$(menu)
    case $choice in
        "Install Arch Mod")
            # Turn off sleep/suspend to avoid interruptions
                gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'false'
                gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'false'
                gsettings set org.gnome.settings-daemon.plugins.power idle-dim 'false'
            echo -e "${YELLOW}Installing Essentials...${NC}"
            # Essentials
                cd scripts || exit
                chmod u+x step-1.sh
                ./step-1.sh
                wait
                cd "$builddir" || exit
            # Install bash support
                # Load user's bashrc
                if [ -f "/home/$username/.bashrc" ]; then
                    . "/home/$username/.bashrc"
                fi
                install_bashrc_support
            echo -e "${GREEN}Essentials Installed successfully!${NC}"
            # Apply Piercing Rice
                echo -e "${YELLOW}Applying PiercingXX Gnome Customizations...${NC}"
                rm -rf piercing-dots
                git clone --depth 1 https://github.com/Piercingxx/piercing-dots.git
                cd piercing-dots || exit
                chmod u+x install.sh
                ./install.sh
                wait
                cd "$builddir" || exit
            # App install
            echo -e "${YELLOW}Installing Core Applications...${NC}"
                cd scripts || exit
                chmod u+x apps.sh
                ./apps.sh
                wait
                cd "$builddir" || exit
            echo -e "${GREEN}Core Apps Installed successfully!${NC}"
            # Hyprland install
            echo -e "${YELLOW}Installing Hyprland & Dependencies...${NC}"
                cd scripts || exit
                chmod u+x hyprland-install.sh
                ./hyprland-install.sh
                cd "$builddir" || exit
            echo -e "${GREEN}Hyprland & Dependencies Installed successfully!${NC}"
            # Enable Bluetooth again
                sudo systemctl start bluetooth
                sudo systemctl enable bluetooth
            # Apply Piercing Gnome Customizations as User
                cd piercing-dots/scripts || exit
                ./gnome-customizations.sh
                wait
                cd "$builddir" || exit
            # Replace .bashrc
                cp -f piercing-dots/resources/bash/.bashrc /home/"$username"/.bashrc
                source "$HOME/.bashrc"
            # Clean Up
                rm -rf piercing-dots
            echo -e "${GREEN}PiercingXX Gnome Customizations Applied successfully!${NC}"
            msg_box "System will reboot now."
            sudo reboot
            ;;
        "Optional Nvidia Drivers")
            echo -e "${YELLOW}Installing Nvidia Drivers...${NC}"
                cd scripts || exit
                chmod +x ./nvidia.sh
                sudo ./nvidia.sh
                cd "$builddir" || exit
            ;;
        "Optional Surface Kernel")
            echo -e "${YELLOW}Microsoft Surface Kernel...${NC}"            
                # Copy systemd service file
                sudo cp scripts/surface-kernel-setup.service /etc/systemd/system/
                sudo install -m 755 scripts/surface-kernel-setup.sh /usr/local/bin/
                sudo systemctl enable --now surface-kernel-setup.service
                cd "$builddir" || exit
                echo -e "${GREEN}Microsoft Kernel Installed.!${NC}"
            ;;
        "Reboot System")
            echo -e "${YELLOW}Rebooting system in 3 seconds...${NC}"
            sleep 1
            reboot
            ;;
        "Exit")
            clear
            echo -e "${BLUE}Thank You Handsome!${NC}"
            exit 0
            ;;
    esac
    read -n 1 -s -r -p "Press any key to continue..."; echo
done
