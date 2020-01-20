
eval "$(direnv hook zsh)"

#----------------------
# Plugin
#----------------------

if [[ ! -d ~/.zplug/ ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:'zplug --self-manage'

#zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

zplug "peco/peco", as:command, from:gh-r, frozen:1
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "motemen/ghq", as:command, from:gh-r, rename-to:ghq
zplug "stedolan/jq", as:command, from:gh-r, rename-to:jq

#zplug "agnoster/agnoster-zsh-theme", as:theme
zplug mafredri/zsh-async, from:github
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

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

alias ll="ls -lhbF"
alias la="ls -lhbFa"


#----------------------
# bindkey
#----------------------

bindkey -e
bindkey '^r' fzf-select-history
bindkey '^f' fzf-src


#----------------------
# function
#----------------------

export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

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
