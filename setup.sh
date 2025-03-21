#!/bin/sh

set -e
set -u

# Install dependencies
brew bundle

# Create symlinks
sh ./create-links.sh
