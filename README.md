# Arch‑Mod

A streamlined installer for a fully‑featured Arch Linux workstation.  
Automates core package installation, GPU drivers, Surface kernel modules, Hyprland, and curated dotfiles.

---

## 📦 Features

- Installs GNOME & Hyprland by default, developer tools, and essential apps
- Applies [Piercing‑Dots](https://github.com/PiercingXX/piercing-dots) dotfiles and customizations
    - Window Manager Dots and all there utilities
      - Hyprland/Awesome/BSPWM/i3/Sway
    - GIMP dots
    - Yazi/kitty setup
    - Scripts that make linux easy:
      - Maintenance.sh - identifies your distro | updates and cleans everything is your system | will auto update any scripts I modify in the github repo.
      - terminal_software_manager.sh - lets you install or uninstall all your software from the terminal even if you dont remember how it was installed, or what the exact name is.
      - open_daily_note.sh - daily notes using nvim and a folder backed up on my own server cloud for sync across all devices.
- Firewall configuration with UFW
- Paru & Flatpak integration and core desktop applications
- Optional NVIDIA driver and Microsoft Surface kernel support

---

## 🚀 Quick Start

```bash
git clone https://github.com/PiercingXX/arch-mod
cd arch-mod
chmod -R u+x scripts/
arch-mod.sh
```

---

## 🛠️ Usage

Run `./arch-mod.sh` and follow the menu prompts.  
Options include system install, NVIDIA drivers, Surface kernel, Hyprland, and reboot.

---

## 🔧 Optional Scripts

| Script                | Purpose                                 |
|-----------------------|-----------------------------------------|
| `scripts/apps.sh`     | Installs core desktop applications      |
| `scripts/hyprland-install.sh` | Installs Hyprland and dependencies |
| `scripts/install-printers.sh` | Configures Canon D530 or Omezizy label printers |
| `scripts/nvidia.sh`   | Installs proprietary NVIDIA drivers     |
| `scripts/Surface.sh`  | Installs Microsoft Surface kernel, script works best with GRUB       |

---

## 📄 License

MIT © PiercingXX  
See the LICENSE file for details.

---

## 🤝 Contributing

Fork, branch, and PR welcome.  

---

## 📞 Support

*No direct support provided.*
```
