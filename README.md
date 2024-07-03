## Getting Started

This project uses [devbox](https://github.com/jetify-com/devbox) to manage its development environment.

Install devbox:
```sh
curl -fsSL https://get.jetpack.io/devbox | bash
```

```sh 
devbox global pull https://github.com/kfly8/dotfiles.git
devbox global install

cd $(devbox global path)
./create-link
```


## Edit the dotfiles

Add a new dependency:
```sh
devbox global add SOMEPACKAGE
```

Push the changes to the repository:
```sh
devbox global push https://github.com/kfly8/dotfiles.git
```
