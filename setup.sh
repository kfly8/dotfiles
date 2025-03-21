#!/bin/sh

set -e
set -u

# Install dependencies
brew bundle
npm install -g @github/copilot-language-server --prefix ~/.config/nvim/copilot/
chmod +x ~/.config/nvim/copilot/bin/copilot-language-server

# Create symlinks
sh ./create-links.sh
