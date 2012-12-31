#!/bin/sh
cd $(dirname $0)

dotfiles=(vimrc vim zshrc zsh gitconfig gitmessage gitignore screenrc tmux.conf)
for (( i = 0; i < ${#dotfiles[*]}; i++ ))
{
  dotfile=${dotfiles[i]}
  path="$PWD/$dotfile"
  target_path=$HOME/.$dotfile
  if [ -L $target_path ]; then
      rm $target_path
  fi
  ln -s $path $target_path
}
