
export PAGER=less
export EDITOR=vim

# Golang
export GOROOT=`go env GOROOT`
export GOPATH=$HOME
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Elixir
export EXENV_ROOT=`exenv ROOT`
export PATH=$PATH:$EXENV_ROOT/bin

# ndenv
export NDENV_ROOT=`ndenv ROOT`
export PATH=$PATH:$NDENV_ROOT/shims

# plenv
export PLENV_ROOT=`plenv ROOT`
export PATH=$PATH:$PLENV_ROOT/shims:$PLENV_ROOT/bin

# mysqlenv
export MYSQLENV_ROOT=~/.mysqlenv
export PATH=$PATH:$MYSQLENV_ROOT/bin:$MYSQLENV_ROOT/shims:$MYSQLENV_ROOT/mysql-build/bin

