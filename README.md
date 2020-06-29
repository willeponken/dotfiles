# My .`<files>`

## Install instructions
### For you

Clone the repository and pick whatever you want!

You can also use `stow` if you want to use a direct copy of something that I'm
using, like this:

*Clone the repository into `~/.dotfiles`:*

```zsh
cd $HOME
git clone git@github.com:wstrm/dotfiles.git .dotfiles
cd .dotfiles
```

*And run `stow` for the configuration you want!*

```zsh
stow neovim  # or any other folder in the root of the repository, e.g. tmux.
```


**A note about Neovim/Vim:**

Neovim/Vim uses Plug, so you have to install all the dependencies, too.

*For Neovim:*

```zsh
nvim +PlugInstall +qall
```

*For Vim:*

```zsh
vim +PlugInstall +qall
```

### For me

```zsh
cd ~
git clone git@github.com:wstrm/dotfiles.git .dotfiles
cd .dotfiles
stow ^(LICENSE|README.md)
cd -
```
