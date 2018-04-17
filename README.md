# dotfiles
This repository is a backup of some of my dotfiles. In the past it has not been maintained well but I hope to change that!

I am currently using Bash 4.4.19 on Mac OS with [iTerm 2](https://www.iterm2.com/).


## Setup
Clone the repository and link the file(s) to your $HOME directory.

```sh
$ cd ~
$ git clone git@github.com:kevingimbel/dotfiles.git
$ ln -s dotfiles/.bash_prompt .
```

### Functions

#### `ws`

`ws` is a function to quickly change the directory into some directory under in my workspace. If I want to go into the directory of the customer XY I'd type `ws xy` - the default settings work for my setup but you may need to change them.

The script uses two config variables:

`WS_DEPTH` is the depth used for `find`, which is used to find a matching directory. The default is 3, add `export WS_DEPTH=4` to `.bash_profile` (or similar) to change it to 4.

`WS_WORKSPACE` is the root workspace directory, in my case `~/Development`. To change it, add `export WS_WORKSPACE=/path/to/your/workspace` to `.bash_profile` (or similar).

### Prompt

The prompt is taken from [Jess Frazelle](https://github.com/jessfraz/dotfiles). It fits my requirements very well and has git integration. The only adjustment so far is the removal of the host because I don't need it.
