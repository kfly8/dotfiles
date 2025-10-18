export LANG=ja_JP.UTF-8

export PAGER=less
export EDITOR=nvim

#--------------------------
# eval
#--------------------------

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"

#--------------------------
# Env
#--------------------------

# PerlNavigatorをカスタマイズしたときの名残
# export PATH="$HOME/src/github.com/kfly8/PerlNavigator/server/bin:/usr/local/bin:$PATH"
# export PATH="/opt/homebrew/bin/:/usr/local/bin:$PATH"
#
export OPENSSL_PREFIX="/opt/homebrew/opt/libressl"
export PATH="$OPENSSL_PREFIX/bin:$PATH"

export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

#
# # FIXME
# #export PGDATA=$DEVBOX_GLOBAL/virtenv/postgresql/data
# #export PGHOST=$DEVBOX_GLOBAL/virtenv/postgresql
#
# # export MYSQL_UNIX_PORT=$DEVBOX_GLOBAL/virtenv/mysql80/run/mysql.sock
# # export MYSQL_PID_FILE=$DEVBOX_GLOBAL/virtenv/mysql80/run/mysql.pid
# # export MYSQL_BASEDIR=$DEVBOX_GLOBAL/nix/profile/default
# # export MYSQL_HOME=$DEVBOX_GLOBAL/virtenv/mysql80/run
# # export MYSQL_DATADIR=$DEVBOX_GLOBAL/virtenv/mysql80/data
#
# # To build Net::SSLeay
# export LDFLAGS="-L$OPENSSL_PREFIX/lib"
# export CPPFLAGS="-I$OPENSSL_PREFIX/include"
#
# # FIXME
# #zstd_version=`zstd --version | perl -nl -e 'print $1 if /v([\d\.]+)/'`
# #zstd_store=`nix-store --query --references $(which zstd) | grep "zstd-$zstd_version$"`
# #mysql_store=`nix-store --query --references $(which mysql) | grep "mysql-wrapped"`
#
# # To build DBD::mysql
# # export LIBRARY_PATH="$mysql_store/lib:$zstd_store/lib:$LIBRARY_PATH"

export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/mysql@8.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql@8.0/include"

#----------------------
# history
#----------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

#--------------------------
# completion
#--------------------------
#
# zsh-completions setting
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# zsh-autosuggestions setting
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting setting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#----------------------
# prompt
#-----------------------

eval "$(starship init zsh)"

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
#alias find="fd"
#alias grep="rg"

alias cdd='fzf-cdr'
alias mm='() { fzf-memo $OBSIDIAN_MEMO_DIR; }'
alias memo='() { fzf-memo $OBSIDIAN_MEMO_DIR; }'
alias en='() { fzf-memo $OBSIDIAN_ENGLISH_DIR; }'
alias english='() { fzf-memo $OBSIDIAN_ENGLISH_DIR; }'

alias jp="perl -MARGV::JSON -MDDP -anl -E "

alias claude="~/.claude/local/claude"

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

export OBSIDIAN_MEMO_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/memo"
export OBSIDIAN_ENGLISH_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/English"

function fzf-memo () {
  if [ -z "$1" ]; then
    echo "Usage: fzf-memo <directory>"
    return 1
  fi

  local dir=$1
  selected_file=$(cd "$dir" && fd . | fzf --preview="bat --color=always --style=numbers {}" --query="$LBUFFER")
  local fzf_exit_code=$?

  if [ -n "$selected_file" ]; then
    nvim $dir/${selected_file}
  elif [ $fzf_exit_code -eq 1 ]; then
    nvim -c "lcd $dir"
  else
    # do nothing when fzf is terminated by other reasons
  fi
}

#----------------------
# local
#----------------------

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/mysql@8.0/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/mysql@8.0/include"

