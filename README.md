# .dotfiles

See the Makefile for commands.

## Directions
Each sub directory should contain a file tree as it would appear in $HOME.

## Stow

Consider the folder

dotfiles/
├── nvim
│   └── .config
│       └── nvim
└── zsh
    └── .zshrc


By running **stow** followed by a folder name we will create symbolic links in the 
parent folder of the current location (here, current location: ~/dotfiles, 
destination location: ~/).


So to create sym links for the config files of nvim and zsh: 

```sh
cd dotfiles
stow nvim
stow zsh
```

which will result in 
(symbolically identical)


parent/
├── .config
│   └── nvim
└── .zshrc



