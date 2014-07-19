autoload -U compinit
compinit

zstyle ':completion:*' list-colors 'di=36' 'ln=35'
zstyle ':completion:*:default' menu select=1

# Initialize colors.
autoload -U colors
colors
 
# Allow for functions in the prompt.
setopt PROMPT_SUBST

# 
setopt nonomatch
 
# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
 
# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions
 
# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
 
# Set the prompt.
PROMPT=$'%{${fg[cyan]}%}%B%d%b$(prompt_git_info)%{${fg[default]}%} '

export MANPATH=$MANPATH:/opt/local/share/man
export LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx
export ANDROID_HOME=$HOME/android/sdk
export ANDROID_NDK_HOME=$HOME/android/ndk
export EDITOR=vim

export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:${PATH}"
#export PATH="${PATH}:$HOME/.nodebrew/current/bin"
#export PATH="${PATH}:$HOME/.rbenv/bin"
#export PATH="${PATH}:$HOME/.plenv/bin"
export PATH="${PATH}:/usr/local/share/python"
export PATH="${PATH}:$HOME/.bist/bin"
export PATH="${PATH}:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools"
export PATH="${PATH}:$ANDROID_NDK_HOME"
export PATH="${PATH}:/usr/local/app/tmux/bin"
export PATH="${PATH}:$GRADLE_HOME/bin"
export PATH="${PATH}:$HOME/bin/gsutil"
export PATH="${PATH}:$HOME/bin"

export GOROOT=`go env GOROOT`
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

if [ -x "`which plenv`" ]; then
  eval "$(plenv init -)"
fi

[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

#export WORKON_HOME=$HOME/.virtualenvs
#. /usr/local/share/python/virtualenvwrapper.sh

export TERM=screen-256color

source "$HOME/.zsh/hook.zshrc"

# alias

case "$OSTYPE" in
    darwin*)
        alias ls="gls"
        ;;
    linux*)
        alias ls="ls"
        ;;
esac
alias ll="ls -lhbF --color=auto"
alias la="ls -lhbFa --color=auto"

if [ -e ~/project/Dev/share/etc/mf-dev.zshrc ];then
    source ~/project/Dev/share/etc/mf-dev.zshrc
fi

if [ -e ~/.mf-k-kobayashi-dev.zshrc ];then
    source ~/.mf-k-kobayashi-dev.zshrc
fi

# 文字コード周り
export LANG=ja_JP.UTF-8
export JLESSCHARSET=japanese
export LANGUAGE=ja_JP.UTF-8

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

export PATH="/usr/local/app/tmux/bin:$PATH"


#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR JENV TO WORK!!!
[[ -s "/Users/kentafly88/.jenv/bin/jenv-init.sh" ]] && source "/Users/kentafly88/.jenv/bin/jenv-init.sh" && source "/Users/kentafly88/.jenv/commands/completion.sh"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export JIRA_HOME=$HOME/project/jira/home
export EDITOR=vim

function peco-snippets() {

    local SNIPPETS=$(cat ~/.sheet_snippets | peco --query "$LBUFFER" | pbcopy)
    zle clear-screen
}
zle -N peco-snippets

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
    eval $tac | \
            peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

bindkey -e
