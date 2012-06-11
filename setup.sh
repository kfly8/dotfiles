#!/bin/sh
cd $(dirname $0)

dotfiles=(vim vimrc zshrc zsh gitconfig screenrc)
for (( i = 0; i < ${#dotfiles[*]}; i++ ))
{
  dotfile=${dotfiles[i]}
  ln -Fs "$PWD/$dotfile" $HOME/.$dotfile
}
