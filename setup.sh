#!/bin/sh
cd $(dirname $0)

dotfiles=(vim vimrc zshrc zsh gitconfig gitmessage gitignore screenrc)
for (( i = 0; i < ${#dotfiles[*]}; i++ ))
{
  dotfile=${dotfiles[i]}
  ln -fs "$PWD/$dotfile" $HOME/.$dotfile
}
