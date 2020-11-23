
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
eval "$(exenv init -)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"
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

#export GOOGLE_CLOUD_SDK_ROOT=~/bin/google-cloud-sdk
#export PATH="$PATH:$GOOGLE_CLOUD_SDK_ROOT/bin"

#source $GOOGLE_CLOUD_SDK_ROOT/completion.zsh.inc
#source $GOOGLE_CLOUD_SDK_ROOT/path.zsh.inc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi
