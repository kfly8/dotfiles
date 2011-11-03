#!/bin/sh
cd $(dirname $0)

for dotfile in .[a-z]*
do
    ln -Fs "$PWD/$dotfile" $HOME
done
