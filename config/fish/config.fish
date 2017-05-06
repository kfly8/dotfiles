# Golang
set -x GOROOT (go env GOROOT)
set -x GOPATH $HOME
set -x PATH $PATH $GOROOT/bin $GOPATH/bin

# Elixir
set -x EXENV_ROOT (exenv ROOT)
set -x PATH $PATH $EXENV_ROOT/bin

# peco
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cf peco_select_ghq_repository
end
