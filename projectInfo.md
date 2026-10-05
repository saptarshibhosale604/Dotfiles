# Project Information: Dotfiles Repository (~/Dotfiles)

## 📌 Project Overview
A centralized repository for personal system configuration files (dotfiles), shell scripts, window manager setups, terminal utilities, and developer environment configs designed for Linux / Raspberry Pi / Arch Linux (Wayland / Hyprland ecosystem).

---

## 🛠️ Technology Stack & Components
- **Window Manager & Compositor:** Hyprland (`Hypr/`)
- **Status Bar & UI:** Wayland bar (`Waybar/`), Wofi app launcher (`Wofi/`), Dunst notifications (`Dunst/`)
- **Terminals & Shells:** Kitty terminal (`Kitty/`), Zsh (`Zshrc/`), Bash (`Bashrc/`)
- **Editors & Utilities:** Neovim (`Nvim/`), Htop (`Htop/`)
- **Automation & Setup:** Custom shell scripts (`Scripts/`)

---

## 📂 Project Structure & Key Directories
- `Hypr/`: Hyprland configuration (`hyprland.conf`, `hypridle.conf`, `hyprlock.conf`, `hyprpaper.conf`, custom scripts)
- `Waybar/`: Wayland status bar configuration (`config.jsonc`, `style.css`)
- `Zshrc/`: Zsh shell configuration and plugins (`zshrc`)
- `Bashrc/`: Bash shell configuration (`bashrc`)
- `Nvim/`: Neovim text editor configuration
- `Kitty/`: Kitty terminal emulator configuration
- `Wofi/`: Wofi application launcher configuration
- `Dunst/`: Dunst notification daemon configuration
- `Htop/`: Htop system monitor configuration
- `Scripts/`: Automation scripts (e.g., `setup_zsh_config.sh`)
- `symlinks.txt`: Documentation of symbolic links connecting dotfiles to `~/.config/`, `~/.zshrc`, etc.
- `README.md`: Git SSH authentication guide and setup instructions

---

## 🚀 Key Features & Setup
1. **Modular Organization:** Clear separation of configurations by tool/app.
2. **Symlink Deployment:** Centralized tracking in `symlinks.txt` allowing quick symlinking to standard system locations (`~/.config/`, `~/.zshrc`, `~/.bashrc`).
3. **Environment Sync:** Easy synchronization across devices using Git and SSH authentication.

---

## 📝 Common Commands & Workflows

### Viewing Symlinks
```bash
cat ~/Dotfiles/symlinks.txt
```

### Checking Git Status
```bash
cd ~/Dotfiles
git status
```
