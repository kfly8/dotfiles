export LANG=ja_JP.UTF-8

export PAGER=less
export EDITOR=vim


#--------------------------
# *env
#--------------------------
export GOENV_ROOT=~/.goenv
export PATH=$PATH:$GOENV_ROOT/bin

export NODENV_ROOT=~/.nodenv
export PATH=$PATH:$NODENV_ROOT/bin

export PLENV_ROOT=~/.plenv
export PATH=$PATH:$PLENV_ROOT/shims:$PLENV_ROOT/bin

export RAKUDOBREW_ROOT=~/.rakudobrew
export PATH=$PATH:$RAKUDOBREW_ROOT/bin

export PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/shims:$PYENV_ROOT/bin

source $HOME/.cargo/env

export PATH="$PATH:/usr/local/bin"

# brew --prefix mysql-client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# brew --prefix openssl
export LIBRARY_PATH="/usr/local/opt/openssl@1.1/lib:$LIBRARY_PATH"

export MONO_GAC_PREFIX="/usr/local"

