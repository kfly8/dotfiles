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

mkdir -p ~/bin
curl -o ~/bin/diff-highlight https://raw.github.com/git/git/master/contrib/diff-highlight/diff-highlight
chmod +x ~/bin/diff-highlight

mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

anyenv install goenv
anyenv install rbenv

goenv install 1.5
go get github.com/nsf/gocode

rbenv install 2.2
gem i rubocop
