# NixOS-Config

Still a nix novice. Slowly building my system.


## Schema

I'm using a flake with currently two outputs to build just my nixos system (I plan on having a nix-Darwin output in the future). One output is for my system configurations and the other is for home-manager wich is responsible for my user configurations. Build commands can be found in my zsh aliases found in my ![user configurations](home.nix).


## Goal

To declare system and user configurations as minimally and consistently as possible. Building from this flake should result in a system identical to mine.

## Themeing

Since ![dwm](https://github.com/Softsun2/dwm) is responsible for my keybinds, I trigger theme loading with dwm. I manage my themes with ![this in progress script](https://github.com/Softsun2/dotfiles-NixOS/blob/main/bin/themecontrol) and a improvised directory structure.
```
softsun2 ~/.dotfiles % tree -a theme
theme
├── .current-theme
└── theme-name
    ├── bg
    │   └── some-background.jpg
    └── theme-name-dwm
```
Where `.current-theme` stores the name of the current theme. Theme names are the names of their associated theme directory. Theme dirs may have a set of backgrounds, backgrounds are choosen randomly when the theme is loaded (provided there are multiple backgrounds). For now I'm only applying colors to dwm via `xrdb`. The schema for defining xcolors (`theme-name-dwm`) is going to change.


## TODO

* Reorder usr vs sys packages & config
* switch back to nvim
* Manage/clean NixOS generations 
* Bar is TERRIBLE (probably due to grep)
* Doc ./bin/audiocontrol
* Fix absolute path to bin in .zshrc
* Fix apply alias (builds result in working dir and not in .dotfiles)
* themeing/dwm patching
* switch to st
* fix themes
* dmenu not displaying suggestions for usr prgrams
* clean home dir

## Imperative components

Things I may or may not declare, keeping a list for future reference.

* kazam config
* discord disable tray & launch on startup
* ssh keys
* Home dir structure
* vscode configurations
* school repos
* docker images/containers/daemon
* steam games
* spotify local file src (probably won't be able to declare this)
