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
zplug 'asdf-vm/asdf'

zplug mafredri/zsh-async, from:github
#zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

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
# asdf
#--------------------------

if [[ -f $ZPLUG_REPOS/asdf-vm/asdf/asdf.sh ]]; then
  source $ZPLUG_REPOS/asdf-vm/asdf/asdf.sh
fi
if [[ -f $ZPLUG_REPOS/asdf-vm/asdf/completions/asdf.zsh ]]; then
  source $ZPLUG_REPOS/asdf-vm/asdf/completions/asdf.zsh
fi

#--------------------------
# direnv
#--------------------------

eval "$(direnv hook zsh)"

#--------------------------
# homebrew
#--------------------------

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:/opt/homebrew/opt/mysql-client:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="$HOME/bin/cvs2svn-2.5.0:$PATH"

#----------------------
# Go
#----------------------

export GOROOT=`go env GOROOT`
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#----------------------
# Rust
#----------------------
export RUST_WITHOUT=rust-docs

#----------------------
# Zig
#----------------------
export PATH="$HOME/src/github.com/zigtools/zls/zig-out/bin:$PATH"

#----------------------
# Grit
#----------------------
export PATH="$PATH:~/.grit/bin"

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

alias ls="exa"
alias l="exa --oneline --git-ignore"
alias ll="exa -lh --git --git-ignore"
alias la="exa -lha --git"
alias tree="exa --tree --git-ignore"

alias cat="bat"
alias find="fd"
#alias grep="rg"

alias cdd='fzf-cdr'

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
# local
#----------------------

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# grit
export GRIT_INSTALL="$HOME/.grit"
export PATH="$GRIT_INSTALL/bin:$PATH"


#----------------------
# LDFLAGS & CPPFLAGS & PKG_CONFIG_PATH
#----------------------
#
export OPENSSL_PREFIX="/opt/homebrew/opt/openssl@1.1"
export LIBJPEG_PREFIX="/opt/homebrew/opt/jpeg"

export LDFLAGS="-L$OPENSSL_PREFIX/lib -L$LIBJPEG_PREFIX/lib"
export CPPFLAGS="-I$OPENSSL_PREFIX/include -I$LIBJPEG_PREFIX/include"

export PKG_CONFIG_PATH="$LIBJPEG_PREFIX/lib/pkgconfig"
