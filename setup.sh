#!/bin/sh
cd $(dirname $0)

ln -s $PWD/config       $HOME/.config
ln -s $PWD/vimrc        $HOME/.vimrc
ln -s $PWD/vim          $HOME/.vim
ln -s $PWD/gitconfig    $HOME/.gitconfig
ln -s $PWD/gitmessage   $HOME/.gitmessage
ln -s $PWD/gitignore    $HOME/.gitignore
ln -s $PWD/tmux.conf    $HOME/.tmux.conf
ln -s $PWD/peco         $HOME/.peco
ln -s $PWD/editorconfig $HOME/.editorconfig
ln -s $PWD/proverc      $HOME/.proverc

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle install

