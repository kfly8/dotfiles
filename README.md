# Setup

## Create dotfiles link

```sh
git clone https://github.com/kfly8/dotfiles.git
cd dotfiles
./create-link
```

## [Homebrew](https://brew.sh)

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew bundle install
```

## [iTerm2](https://www.iterm2.com/)

Load Preferences `dotfiles/iTerm2/`

# Vim

## Navigate

|                  | Go to src file | Go to definition/declation | Go to document |                                             Vim Plugin |                                       Remark |
|:-----------------|:--------------:|:--------------------------:|:--------------:|:------------------------------------------------------:|:--------------------------------------------:|
| Perl             |             gf |                         gd |  :Perldoc or K | y-uuki/perl-local-lib-path.vim, hotchpotch/perldoc-vim |                                              |
| Golang           |             gd |               :GoDef or gd |    :GoDoc or K | fatih/vim-go                                           | Necessary to work with $GOPATH               |
| Elixir           |             gf |               :ExDef or gd |    :ExDoc or K | elixir-lang/vim-elixir, slashmili/alchemist.vim        | [Necessary to install Elixir with source code](https://github.com/mururu/elixir-build#keeping-the-build-directory-after-installation) |


---------
Suggestions/Improvements [welcome](https://github.com/kfly8/dotfiles/issues)

