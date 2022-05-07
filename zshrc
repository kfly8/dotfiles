export LANG=ja_JP.UTF-8

export PAGER=less
export EDITOR=nvim

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
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug 'asdf-vm/asdf'

zplug mafredri/zsh-async, from:github
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

#--------------------------
# *env
#--------------------------
export GOENV_ROOT=~/.goenv
export PATH=$PATH:$GOENV_ROOT/bin

export PLENV_ROOT=~/.plenv
export PATH=$PATH:$PLENV_ROOT/shims:$PLENV_ROOT/bin

export RBENV_ROOT=~/.rbenv
export PATH=$PATH:$RBENV_ROOT/bin

export PATH="/usr/local/bin:$PATH"

# asdf
if [[ -f $ZPLUG_REPOS/asdf-vm/asdf/asdf.sh ]]; then
  source $ZPLUG_REPOS/asdf-vm/asdf/asdf.sh
fi
if [[ -f $ZPLUG_REPOS/asdf-vm/asdf/completions/asdf.zsh ]]; then
  source $ZPLUG_REPOS/asdf-vm/asdf/completions/asdf.zsh
fi

# brew --prefix python
export PATH="/usr/local/opt/python3/bin:/opt/homebrew/opt/python@3.9:$PATH"

# brew --prefix mysql-client
export PATH="/usr/local/opt/mysql-client/bin:/opt/homebrew/opt/mysql-client:$PATH"

# brew --prefix openssl
#export LIBRARY_PATH="/usr/local/opt/openssl@1.1/lib:/opt/homebrew/opt/openssl@1.1:$LIBRARY_PATH"

export MONO_GAC_PREFIX="/usr/local"

if [[ ! -d ~/.goenv ]]; then
  git clone https://github.com/syndbg/goenv.git ~/.goenv
fi

if [[ ! -d ~/.plenv ]]; then
  git clone https://github.com/tokuhirom/plenv.git ~/.plenv
fi

if [[ ! -d ~/.plenv/plugins/perl-build ]]; then
  git clone https://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build
fi

if [[ ! -d ~/.rbenv ]]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

if [[ ! -d ~/.rbenv/plugins/ruby-build ]]; then
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

eval "$(goenv init -)"
eval "$(nodenv init -)"
eval "$(plenv init - zsh)"
eval "$(rbenv init -)"

if (( ! ${+commands[go]} )); then
  GOLATEST=`goenv install --list | tail -1`
  `echo $GOLATEST | xargs goenv install & goenv rehash`
  `echo $GOLATEST | xargs goenv global`
fi

export GOROOT=`go env GOROOT`
export GOPATH=$HOME/.go

export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#----------------------
# flutter
#----------------------

export PATH=$PATH:$HOME/flutter/bin

#----------------------
# gcloud
#----------------------
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

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

alias vim="nvim"

alias ls="exa"
alias l="exa --oneline --git-ignore"
alias ll="exa -lh --git --git-ignore"
alias la="exa -lha --git"
alias tree="exa --tree --git-ignore"

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


# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/kfly8/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
