# NixOS-Config

Still a nix novice. Slowly building my system.


## Schema

I'm using a flake with currently two outputs to build just my nixos system (I plan on having a nix-Darwin output in the future). One output is for my system configurations and the other is for home-manager wich is responsible for my user configurations. Build commands can be found in my zsh aliases found in my ![user configurations](home.nix).


## Goal

To declare system and user configurations as minimally and consistently as possible. Building from this flake should result in a system identical to mine.

## Themeing

I now use flavours. This is temporary as it sort of goes against nix philosophy for applications that cannot be configured with multiple config files. Flavours should not be managing any configuration settings for applications, just color settings.

Apps I still need to theme/flavour:
  1. firefox
  2. spotify?
  3. exa
  4. vim (base16 plugin) (is there treesitter support for this??)
  5. zathura
  6. discord

## TODO
* return to just one package repository
* Determine why system is crashing/freezing
* Flake lock file branch
* Reorder usr vs sys packages & config
* Make neovim more usable
* Manage/clean NixOS generations 
* Bar is TERRIBLE (probably due to grep)
* Getting tired of dwm look into switching
* Themeing/dwm patching
  * Look into a nix-y way of using flavours w/ bgs
  * Or find a way to generate config files w/ a base16 input list
* Make a handful of decent themes then never theme again (at least for awhile)
* Clean home dir
* Setup ssh server

## Imperative components

Things I may or may not declare, keeping a list for future reference.

* Discord disable tray & launch on startup
* Ssh keys
* Home dir structure
* Vscode configurations
* School repos
* Docker images/containers/daemon
* Steam games
* Spotify local file src (probably won't be able to declare this)
