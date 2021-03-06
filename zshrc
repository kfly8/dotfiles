export LANG=ja_JP.UTF-8

export PAGER=less
export EDITOR=vim

eval "$(direnv hook zsh)"

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

zplug "motemen/ghq", as:command, from:gh-r, rename-to:ghq
zplug "stedolan/jq", as:command, from:gh-r, rename-to:jq

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# redefine prompt_context for hiding user@hostname
prompt_context () { }


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

source $HOME/.cargo/env

export PATH="$PATH:/usr/local/bin"

# brew --prefix python
export PATH="/usr/local/opt/python3/bin:$PATH"

# brew --prefix mysql-client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# brew --prefix openssl
export LIBRARY_PATH="/usr/local/opt/openssl@1.1/lib:$LIBRARY_PATH"

export MONO_GAC_PREFIX="/usr/local"

if [[ ! -d ~/.goenv ]]; then
  git clone https://github.com/syndbg/goenv.git ~/.goenv
fi

if [[ ! -d ~/.nodenv ]]; then
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv
fi

if [[ ! -d ~/.plenv ]]; then
  git clone https://github.com/tokuhirom/plenv.git ~/.plenv
fi

if [[ ! -d ~/.plenv/plugins/perl-build ]]; then
  git clone https://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
fi

if [[ ! -d ~/.rakudobrew ]]; then
  git clone https://github.com/tadzik/rakudobrew.git ~/.rakudobrew
fi

if [[ ! -d ~/.cargo ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

eval "$(goenv init -)"
eval "$(nodenv init -)"
eval "$(plenv init - zsh)"
eval "$(rakudobrew init -)"

if (( ! ${+commands[go]} )); then
  GOLATEST=`goenv install --list | tail -1`
  `echo $GOLATEST | xargs goenv install & goenv rehash`
  `echo $GOLATEST | xargs goenv global`
fi

export GOROOT=`go env GOROOT`
export GOPATH=$HOME

export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH="$HOME/.cargo/bin:$PATH"


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
# alias
#----------------------

alias ls="exa"
alias l="exa --oneline"
alias ll="exa -lh --git"
alias la="exa -lha --git"
alias tree="exa --tree"

alias cat="bat"
alias find="fd"
#alias grep="rg"

#----------------------
# bindkey
#----------------------

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

alias cdd='fzf-cdr'
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
