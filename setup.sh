#!/bin/sh
cd $(dirname $0)

for dotfile in .[a-z]*
do
    if [ $dotfile != '.git' ]
    then
     ln -Fs "$PWD/$dotfile" $HOME
    fi
done
