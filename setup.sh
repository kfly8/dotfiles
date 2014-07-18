#!/bin/sh
cd $(dirname $0)

dotfiles=(vimrc vim zshrc zsh gitconfig gitmessage gitignore screenrc tmux.conf sheets sheet_snippets peco)
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

go get github.com/nsf/gocode

git submodule update --init
vim +NeoBundleInstall! +qa

cd vim/neobundle/vimproc
make
