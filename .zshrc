autoload -U compinit
compinit

zstyle ':completion:*' list-colors 'di=36' 'ln=35'
zstyle ':completion:*:default' menu select=1

# Initialize colors.
autoload -U colors
colors
 
# Allow for functions in the prompt.
setopt PROMPT_SUBST
 
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
export MANPATH=$MANPATH:/opt/local/share/man
export LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx


source "$HOME/.zsh/hook.zshrc"
#_show_dirname_on_screen_title(){
#    echo -ne "\ek$(basename $(pwd))\e\\"
#}
#
##set title
#case "${TERM}" in screen)
#    preexec(){
#        echo -ne "\ek#${1%%*}\e\\"
#    }
#    precmd(){
#        _show_dirname_on_screen_title
#    }
#    chpwd(){
#        _show_dirname_on_screen_title
#    }
#esac

# alias
alias sl="ls -hblFG"
alias ls="ls -hblFG"
alias la="ls -hblFGa"

source ~/perl5/perlbrew/etc/bashrc
