#!/bin/sh
cd $(dirname $0)

dotfiles=(vimrc vim zshrc zsh gitconfig gitmessage gitignore screenrc tmux.conf sheets sheet_snippets peco editorconfig)
for (( i = 0; i < ${#dotfiles[*]}; i++ ))
{
  dotfile=${dotfiles[i]}
  path="$PWD/$dotfile"
  target_path=$HOME/.$dotfile
  ln -s $path $target_path
}

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle install

