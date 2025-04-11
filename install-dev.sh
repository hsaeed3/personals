#!/bin/bash

# Exit script if any command fails
set -e

echo "===== Installing Oh My Bash and uv Package Manager ====="
echo

# Check if bash is installed
if ! command -v bash &> /dev/null; then
    echo "Bash is not installed. Please install bash first."
    exit 1
fi

# Install Oh My Bash if not already installed
if [ ! -d "$HOME/.oh-my-bash" ]; then
    echo "Installing Oh My Bash..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" "" --unattended
    echo "Oh My Bash installed successfully!"
else
    echo "Oh My Bash is already installed."
fi

# Install uv package manager
echo "Installing uv package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Make sure uv is in the path
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
fi

# Add uv shell completion to .bashrc if not already present
if ! grep -q "uv generate-shell-completion bash" ~/.bashrc; then
    echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
    echo "Added uv shell completion to .bashrc"
fi

# Source the bashrc file to apply changes
echo "Configuration complete!"
echo
echo "===== Installation Summary ====="
echo "1. Oh My Bash has been installed (or was already installed)"
echo "2. uv package manager has been installed"
echo "3. uv shell completion has been added to your .bashrc"
echo
echo "To apply changes to your current session, run:"
echo "   source ~/.bashrc"
echo
echo "Or simply close and reopen your terminal."
echo
echo "Enjoy your enhanced shell experience!"

# If this script was sourced (not executed directly), source the bashrc
# Otherwise, suggest sourcing
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    source ~/.bashrc
    echo "Changes have been applied to current session!"
else
    echo "To apply changes now, run: source ~/.bashrc"
fi
