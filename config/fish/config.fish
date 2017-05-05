# Golang
set -x GOROOT (go env GOROOT)
set -x GOPATH $HOME
set -x PATH $PATH $GOROOT/bin $GOPATH/bin 

# peco
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \c] peco_select_ghq_repository
end
