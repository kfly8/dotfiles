# alias
alias rm='rmtrash'

# peco
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \c] peco_select_ghq_repository
end
