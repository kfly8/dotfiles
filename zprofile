
#--------------------------
# *env
#--------------------------
if [[ ! -d ~/.goenv ]]; then
  git clone https://github.com/syndbg/goenv.git ~/.goenv
fi

if [[ ! -d ~/.exenv ]]; then
  git clone git://github.com/mururu/exenv.git ~/.exenv
fi

if [[ ! -d ~/.ndenv ]]; then
  git clone https://github.com/riywo/ndenv ~/.ndenv
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

eval "$(goenv init -)"
eval "$(exenv init -)"
eval "$(ndenv init -)"
eval "$(plenv init - zsh)"
eval "$(rakudobrew init -)"


#--------------------------
# golang
#--------------------------
if (( ! ${+commands[go]} )); then
  GOLATEST=`goenv install --list | tail -1`
  `echo $GOLATEST | xargs goenv install & goenv rehash`
  `echo $GOLATEST | xargs goenv global`
fi

export GOROOT=`go env GOROOT`
export GOPATH=$HOME
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

