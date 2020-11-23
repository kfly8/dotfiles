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

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
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

#export FZF_DEFAULT_OPTS='--ansi --height 50% --layout=reverse --border'
export FZF_DEFAULT_OPTS='--ansi --color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'

export FZF_DEFAULT_COMMAND='fd --type file --color=always'


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

#----------------------
# local
#----------------------

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
