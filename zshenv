
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

export RAKUDOBREW_ROOT=~/.rakudobrew
export PATH=$PATH:$RAKUDOBREW_ROOT/bin

export PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/shims:$PYENV_ROOT/bin

export RBENV_ROOT=~/.rbenv
export PATH=$PATH:$RBENV_ROOT/shims:$RBENV_ROOT/bin

export MYSQLENV_ROOT=~/.mysqlenv
export PATH=$PATH:$MYSQLENV_ROOT/bin:$MYSQLENV_ROOT/shims:$MYSQLENV_ROOT/mysql-build/bin:$MYSQLENV_ROOT/mysqls/5.6.23/scripts

export MONO_GAC_PREFIX="/usr/local"
