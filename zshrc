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
PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '

export MANPATH=$MANPATH:/opt/local/share/man
export LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx
export ANDROID_HOME=$HOME/android/sdk
export ANDROID_NDK_HOME=$HOME/android/ndk

export PATH="${PATH}:/opt/local/bin:/opt/local/sbin:/usr/local/bin"
export PATH="${PATH}:$HOME/.nodebrew/current/bin"
export PATH="${PATH}:$HOME/.rbenv/bin"
export PATH="${PATH}:$HOME/.plenv/bin"
export PATH="${PATH}:/usr/local/share/python"
export PATH="${PATH}:$HOME/.bist/bin"
export PATH="${PATH}:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools"
export PATH="${PATH}:$ANDROID_NDK_HOME"
export PATH="${PATH}:/usr/local/app/tmux/bin"
export PATH="${PATH}:$HOME/bin"
eval "$(plenv init -)"

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

# 文字コード周り
export LANG=ja_JP.UTF-8
export JLESSCHARSET=japanese

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

export PATH="/usr/local/app/tmux/bin:$PATH"

