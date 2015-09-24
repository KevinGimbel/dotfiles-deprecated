#~/dotfiles

Here I store all my dotfiles, so may others will judge me or call me a n00b.

Help and improvments always appreciated.

## Usage
How I am using and storing files at the moment. "Simply" symlinkin' the files to
the home directory.

```sh
$ cd ~
$ git clone git@github.com:kevingimbel/dotfiles.git
$ ln -s dotfiles/.zshrc .
```

## .aliases
Since I'm switching between `bash` and `zsh` some times I figured putting my aliases inside a `.aliases` file and including this file is not a bad idea.

## oh-my-zsh
The oh-my-zsh folder holds all customizations I made for the [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).

## vim/nvim
`.vimrc` and `.nvimrc` are mostly the same. I use [neovim](http://neovim.org) every now and then instead of vim to see how development goes.

## local/bin
Holds some shell scripts (or better "helpers") that I use every now and then. Most important is `startenv` which is a short code for
```sh
sudo service apache2 start && sudo service mysql start
```
