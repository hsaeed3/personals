#!/bin/bash

# Exit script if any command fails
set -e

echo "===== Installing Oh My Zsh and uv Package Manager ====="
echo

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please install zsh first."
    exit 1
fi

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "Oh My Zsh installed successfully!"
else
    echo "Oh My Zsh is already installed."
fi

# Install uv package manager
echo "Installing uv package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Make sure uv is in the path
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
fi

# Add uv shell completion to .zshrc if not already present
if ! grep -q "uv generate-shell-completion zsh" ~/.zshrc; then
    echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
    echo "Added uv shell completion to .zshrc"
fi

# Source the zshrc file to apply changes
echo "Configuration complete!"
echo
echo "===== Installation Summary ====="
echo "1. Oh My Zsh has been installed (or was already installed)"
echo "2. uv package manager has been installed"
echo "3. uv shell completion has been added to your .zshrc"
echo
echo "To apply changes to your current session, run:"
echo "   source ~/.zshrc"
echo
echo "Or simply close and reopen your terminal."
echo
echo "Enjoy your enhanced shell experience!"

# If this script was sourced (not executed directly), source the zshrc
# Otherwise, suggest sourcing
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    source ~/.zshrc
    echo "Changes have been applied to current session!"
else
    echo "To apply changes now, run: source ~/.zshrc"
fi
