# NixOS-Config

Still a nix novice. Slowly building my system.


## Schema

I'm using a flake with currently two outputs to build just my nixos system (I plan on having a nix-Darwin output in the future). One output is for my system configurations and the other is for home-manager wich is responsible for my user configurations. Build commands can be found in my zsh aliases found in my ![user configurations](home.nix).


## Goal

  To declare system and user configurations as minimally and consistently as possible. Building from this flake should result in a system identical to mine.


## TODO

* Reorder usr vs sys packages & config
* switch back to nvim
* Manage/clean NixOS generations 
* Bar is TERRIBLE (probably due to grep)
* Doc ./bin/audiocontrol
* Fix absolute path to bin in .zshrc
* Fix apply alias (builds result in working dir and not in .dotfiles)
* themeing/dwm patching
* switch to a different terminal emulator (maybe)
* dmenu not displaying suggestions for usr prgrams
* clean home dir
* vscode open file abs path and not gui

## Imperative components

Things I may or may not declare, keeping a list for future reference.

* discord disable tray & launch on startup
* ssh keys
* Home dir structure
* vscode configurations
* school repos
* docker images/containers/daemon
* steam games
* spotify local file src (probably won't be able to declare this)
