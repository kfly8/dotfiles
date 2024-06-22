export LANG=ja_JP.UTF-8

export PAGER=less
export EDITOR=nvim
#----------------------
# Plugin
#----------------------

if [[ ! -d ~/.zplug/ ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-completions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

#--------------------------
# completion
#--------------------------

export FPATH="$HOME/.zsh/completion:$FPATH"

autoload -U compinit
compinit -i

#--------------------------
# devbox
#--------------------------

eval "$(devbox global shellenv)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

export PATH="/usr/local/bin:$PATH"

#----------------------
# cdr
#----------------------
autoload -U chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":chpwd:*" recent-dirs-default on
zstyle ":completion:*" recent-dirs-insert always
zstyle ":completion:*:*:cdr:*:*" menu select=2

#----------------------
# history
#----------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

#----------------------
# alias & bindkey
#----------------------

alias vim="nvim"

alias ls="eza"
alias l="eza --oneline --git-ignore"
alias ll="eza -lh --git --git-ignore"
alias la="eza -lha --git"
alias tree="eza --tree --git-ignore"

alias cat="bat"
alias find="fd"
#alias grep="rg"

alias cdd='fzf-cdr'
alias mm='fzf-memo'
alias memo='fzf-memo'

bindkey -e
bindkey '^r' fzf-select-history
bindkey '^f' fzf-src

#----------------------
# fzf
#----------------------

export FZF_DEFAULT_COMMAND='fd --type file --color=always'
export FZF_DEFAULT_OPTS='--ansi --color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'

function fzf-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(history -n 1 | eval $tac | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf-select-history

function fzf-src () {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-src

function fzf-cdr() {
  target_dir=`cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf`
  target_dir=`echo ${target_dir/\~/$HOME}`
  if [ -n "$target_dir" ]; then
    cd $target_dir
  fi
}

#----------------------
# Memo
#----------------------

export MEMOLIST_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/memo"

function fzf-memo () {
  selected_file=$(cd "$MEMOLIST_DIR" && ls | fzf --preview="bat {}" --query="$LBUFFER")

  if [ -n "$selected_file" ]; then
    nvim $MEMOLIST_DIR/${selected_file}
  else
    nvim -c "lcd $MEMOLIST_DIR"
  fi
}

#----------------------
# local
#----------------------

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

