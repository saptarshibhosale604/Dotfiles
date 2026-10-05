#!/usr/bin/env bash
# ==============================================================================
# zsh_config.sh
# Interactive step-by-step script to install and configure Zsh, Oh My Zsh,
# essential plugins, and set Zsh as the default shell.
# Each step explains what it will do and asks for user confirmation.
# ==============================================================================

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

prompt_confirmation() {
    local step_name="$1"
    echo -e "\n${YELLOW}------------------------------------------------------------${NC}"
    echo -e "${BLUE}Ready to execute Step:${NC} $step_name"
    echo -e "${YELLOW}------------------------------------------------------------${NC}"
    read -p "Do you want to run this step? (y/n): " choice
    case "$choice" in 
        y|Y ) return 0 ;;
        * ) echo -e "${RED}Skipping step: $step_name${NC}"; return 1 ;;
    esac
}

echo -e "${GREEN}=== Interactive Zsh Configuration Script ===${NC}"
echo "This script will guide you through setting up Zsh step by step."

# ------------------------------------------------------------------------------
# Step 1: Install Zsh
# ------------------------------------------------------------------------------
if prompt_confirmation "Step 1: Install Zsh"; then
    echo -e "${BLUE}[INFO] Checking if zsh is installed...${NC}"
    if command -v zsh &> /dev/null; then
        echo -e "${GREEN}[SUCCESS] zsh is already installed at $(which zsh).${NC}"
    else
        echo -e "${BLUE}[INFO] Installing zsh via apt package manager...${NC}"
        sudo apt update && sudo apt install -y zsh curl git
        echo -e "${GREEN}[SUCCESS] zsh installed successfully.${NC}"
    fi
else
    echo "Skipped Step 1."
fi

# ------------------------------------------------------------------------------
# Step 2: Install Oh My Zsh
# ------------------------------------------------------------------------------
if prompt_confirmation "Step 2: Install Oh My Zsh"; then
    echo -e "${BLUE}[INFO] Checking if Oh My Zsh is installed...${NC}"
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${GREEN}[SUCCESS] Oh My Zsh is already installed at $HOME/.oh-my-zsh.${NC}"
    else
        echo -e "${BLUE}[INFO] Installing Oh My Zsh non-interactively...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
        echo -e "${GREEN}[SUCCESS] Oh My Zsh installed successfully.${NC}"
    fi
else
    echo "Skipped Step 2."
fi

# ------------------------------------------------------------------------------
# Step 3: Install Essential Zsh Plugins (autosuggestions & syntax-highlighting)
# ------------------------------------------------------------------------------
if prompt_confirmation "Step 3: Install Zsh Plugins (autosuggestions & syntax-highlighting)"; then
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    # 1. zsh-autosuggestions
    AUTO_SUGGEST_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    if [ -d "$AUTO_SUGGEST_DIR" ]; then
        echo -e "${GREEN}[SUCCESS] zsh-autosuggestions is already installed.${NC}"
    else
        echo -e "${BLUE}[INFO] Cloning zsh-autosuggestions...${NC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTO_SUGGEST_DIR"
        echo -e "${GREEN}[SUCCESS] zsh-autosuggestions installed.${NC}"
    fi

    # 2. zsh-syntax-highlighting
    SYNTAX_HL_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    if [ -d "$SYNTAX_HL_DIR" ]; then
        echo -e "${GREEN}[SUCCESS] zsh-syntax-highlighting is already installed.${NC}"
    else
        echo -e "${BLUE}[INFO] Cloning zsh-syntax-highlighting...${NC}"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_HL_DIR"
        echo -e "${GREEN}[SUCCESS] zsh-syntax-highlighting installed.${NC}"
    fi
else
    echo "Skipped Step 3."
fi

# ------------------------------------------------------------------------------
# Step 4: Configure Zsh Theme and Plugins in ~/.zshrc
# ------------------------------------------------------------------------------
if prompt_confirmation "Step 4: Configure plugins and theme in ~/.zshrc"; then
    ZSHRC="$HOME/.zshrc"
    if [ ! -f "$ZSHRC" ]; then
        echo -e "${BLUE}[INFO] Creating default ~/.zshrc from template...${NC}"
        cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$ZSHRC"
    fi

    echo -e "${BLUE}[INFO] Updating plugins list in ~/.zshrc...${NC}"
    # Ensure plugins=(git zsh-autosuggestions zsh-syntax-highlighting) is configured
    if grep -q "^plugins=(" "$ZSHRC"; then
        sed -i 's/^plugins=(.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
    else
        echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
    fi
    echo -e "${GREEN}[SUCCESS] ~/.zshrc plugins updated successfully.${NC}"
else
    echo "Skipped Step 4."
fi

# ------------------------------------------------------------------------------
# Step 5: Set Zsh as Default Shell
# ------------------------------------------------------------------------------
if prompt_confirmation "Step 5: Set Zsh as Default Shell"; then
    ZSH_PATH="$(which zsh)"
    CURRENT_SHELL="$SHELL"
    
    if [ "$CURRENT_SHELL" = "$ZSH_PATH" ]; then
        echo -e "${GREEN}[SUCCESS] Zsh is already your default shell!${NC}"
    else
        echo -e "${BLUE}[INFO] Changing default shell to $ZSH_PATH (may prompt for sudo password)...${NC}"
        chsh -s "$ZSH_PATH" || sudo chsh -s "$ZSH_PATH" "$USER"
        echo -e "${GREEN}[SUCCESS] Default shell changed to Zsh. (Note: Restart your terminal session to take full effect).${NC}"
    fi
else
    echo "Skipped Step 5."
fi

# ------------------------------------------------------------------------------
# Step 6: Verification
# ------------------------------------------------------------------------------
if prompt_confirmation "Step 6: Verification"; then
    echo -e "${BLUE}[INFO] Verifying Zsh environment...${NC}"
    echo -e "Zsh version: $(zsh --version)"
    echo -e "Current \$SHELL: $SHELL"
    echo -e "${GREEN}[SUCCESS] Zsh setup verification complete!${NC}"
else
    echo "Skipped Step 6."
fi

echo -e "\n${GREEN}=== Zsh Configuration Script Completed ===${NC}"
