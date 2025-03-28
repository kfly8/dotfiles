#!/bin/sh

set -e
set -u

create_symlink() {
  target=$1
  link_name=$2

  if [ -L "$link_name" ]; then
    if [ "$(readlink "$link_name")" != "$target" ]; then
      echo "Updating symlink: $link_name -> $target"
      ln -sf "$target" "$link_name"
    else
      echo "Symlink already correct: $link_name -> $target"
    fi
  elif [ -e "$link_name" ]; then
    echo "Removing existing file and creating symlink: $link_name -> $target"
    rm -rf "$link_name"
    ln -s "$target" "$link_name"
  else
    echo "Creating symlink: $link_name -> $target"
    ln -s "$target" "$link_name"
  fi
}

echo 'Creating symlinks...'

create_symlink "$PWD/zshrc"           "$HOME/.zshrc"
create_symlink "$PWD/zsh"             "$HOME/.zsh"
create_symlink "$PWD/gitconfig"       "$HOME/.gitconfig"
create_symlink "$PWD/gitmessage"      "$HOME/.gitmessage"
create_symlink "$PWD/gitignore"       "$HOME/.gitignore"
create_symlink "$PWD/tmux.conf"       "$HOME/.tmux.conf"
create_symlink "$PWD/textlintrc"      "$HOME/.textlintrc"
create_symlink "$PWD/proverc"         "$HOME/.proverc"
create_symlink "$PWD/editorconfig"    "$HOME/.editorconfig"
create_symlink "$PWD/Brewfile"        "$HOME/Brewfile"

mkdir -p $HOME/.config
create_symlink "$PWD/config/nvim"           "$HOME/.config/nvim"
create_symlink "$PWD/config/pet"            "$HOME/.config/pet"
create_symlink "$PWD/config/efm-langserver" "$HOME/.config/efm-langserver"
create_symlink "$PWD/config/perlimports"    "$HOME/.config/perlimports"
create_symlink "$PWD/config/starship.toml"  "$HOME/.config/starship.toml"
create_symlink "$PWD/config/nix"            "$HOME/.config/nix"
create_symlink "$PWD/config/memo"           "$HOME/.config/memo"
create_symlink "$PWD/config/typos.toml"     "$HOME/.config/typos.toml"

echo 'Done!'
