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

export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.rbenv/bin:$HOME/bin:$PATH"
export PATH=$PATH:/usr/local/share/python
export PATH="$PATH:/Users/kfly8/.bist/bin"
export MANPATH=$MANPATH:/opt/local/share/man
export LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx

#export WORKON_HOME=$HOME/.virtualenvs
#. /usr/local/share/python/virtualenvwrapper.sh

source "$HOME/.zsh/hook.zshrc"
source "$HOME/.zprofile"

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

source ~/perl5/perlbrew/etc/bashrc
