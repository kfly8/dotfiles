
export LANG=ja_JP.UTF-8

export PAGER=less
export EDITOR=vim

#--------------------------
# *env
#--------------------------
export GOENV_ROOT=~/.goenv
export PATH=$PATH:$GOENV_ROOT/bin

export EXENV_ROOT=~/.exenv
export PATH=$PATH:$EXENV_ROOT/bin

export NDENV_ROOT=~/.ndenv
export PATH=$PATH:$NDENV_ROOT/shims:$NDENV_ROOT/bin

export PLENV_ROOT=~/.plenv
export PATH=$PATH:$PLENV_ROOT/shims:$PLENV_ROOT/bin

export MYSQLENV_ROOT=~/.mysqlenv
export PATH=$PATH:$MYSQLENV_ROOT/bin:$MYSQLENV_ROOT/shims:$MYSQLENV_ROOT/mysql-build/bin

if [[ ! -d ~/.goenv ]]; then
  git clone https://github.com/syndbg/goenv.git ~/.goenv
fi

if [[ ! -d ~/.exenv ]]; then
  git clone git://github.com/mururu/exenv.git ~/.exenv
fi

if [[ ! -d ~/.ndenv ]]; then
  git clone https://github.com/riywo/ndenv ~/.ndenv
fi

if [[ ! -d ~/.plenv ]]; then
  git clone https://github.com/tokuhirom/plenv.git ~/.plenv
fi

eval "$(goenv init -)"
eval "$(exenv init -)"
eval "$(ndenv init -)"
eval "$(plenv init -)"


#--------------------------
# golang
#--------------------------
if (( ! ${+commands[go]} )); then
  GOLATEST=`goenv install --list | tail -1`
  `echo $GOLATEST | xargs goenv install & goenv rehash`
  `echo $GOLATEST | xargs goenv global`
fi

export GOROOT=`go env GOROOT`
export GOPATH=$HOME
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

