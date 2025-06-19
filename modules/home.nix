{ config, pkgs, lib, ... }:
{
  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  # pin home manager modules/packages to the latest nix-stable channel
  home.stateVersion = "25.05";

  home.username = "softsun2";
  home.homeDirectory = /Users/softsun2; # @todo: system based
  home.packages = with pkgs; [
    # fonts
    fontconfig meslo-lg ubuntu-sans-mono

    # dev
    python3 tldr tree jq

    # @todo: nixos pkgs
    # st docker lshw dmidecode xclip
    # qutebrowser

    # networking
    miniupnpc

    # media
    ffmpeg yt-dlp

    # dev tools
    tldr tree plistwatch jq

    # emacs extra packages
    nixfmt-classic graphviz ispell
  ];
  fonts.fontconfig.enable = true;

  # @todo: system dependent
  # home.file.".xinitrc" = {
  #   text = "
  #     #!/bin/sh
  #
  #     # background
  #     feh --bg-max ${config.home.homeDirectory}/Pictures/dark-bgs/IMG-5709.jpg;
  #
  #     # status bar
  #     ${config.home.homeDirectory}/.dotfiles/bin/bar;
  #
  #     # X Colors
  #     xrdb ${config.home.homeDirectory}/.Xresources;
  #
  #     exec dwm &> ${config.home.homeDirectory}/.dwm-log.out
  #   ";
  # };

  # TODO: use a list or something
  home.file."${config.home.username}/org/.keep".text = "";
  home.file."${config.home.username}/archive/.keep".text = "";
  home.file."${config.home.username}/git/.keep".text = "";
  home.file."${config.home.username}/documents/.keep".text = "";
  home.file."${config.home.username}/literature/.keep".text = "";
  home.file."${config.home.username}/music/.keep".text = "";
  home.file."${config.home.username}/pictures/.keep".text = "";
  home.file."${config.home.username}/school/.keep".text = "";
  home.file."${config.home.username}/videos/.keep".text = "";
  home.file."${config.home.username}/writing/.keep".text = "";

  # added to .profile
  home.sessionPath = [
    "${config.home.homeDirectory}/.dotfiles/bin"
  ];

  # @todo: don't really need this on darwin
  home.sessionVariables = {
    SS2_DARK_THEME = 1;
  };

  home.shellAliases = {
    c = "clear";
    l = "ls -l";
    ll = "ls -al";
    ".." = "cd ..";
  };

  # @todo: device dependent
  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      options = {
        relaysEnabled = true;
        urAccepted = -1; # disable anonymous usage data collection
      };
      devices.buffalo.id = "DWIDPQK-OJP2OPA-DG2JHVQ-PXVK6PN-64AZ5RZ-LFN6YQJ-E4UTCFI-NRRGNQW";
      devices.cicada.id = "R5IMJUF-3UTE3HJ-DU5PMQO-GZZ5LX4-RGDBI5S-O7QD2UB-MJCZ5UZ-ZY33FAH";
      folders.org = {
        path = "${config.home.homeDirectory}/${config.home.username}/org";
        devices = [ "buffalo" "cicada" ];

      # devices.woollymammoth.id = "AXQZZYW-NORHZHC-W4VEXSA-L7CNK2E-2FOUHCF-YHU6REP-34LXB4F-AI56WAF";
        # devices = [ "woollymammoth" "cicada" ];
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      home-switch = "home-manager switch --flake ${config.home.homeDirectory}/.dotfiles";
      darwin-switch = "darwin-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles";
      # @todo: device dependent
      # nixos-switch = "sudo nixos-rebuild switch --impure --flake ${config.home.homeDirectory}/.dotfiles";
      # window role patch support
      # https://nixos.wiki/wiki/Emacs#Window_manager_integration
      emacs = "${config.programs.emacs.finalPackage}/Applications/Emacs.app/Contents/MacOS/Emacs";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.firefox.enable = true;

  programs.emacs = {
    enable = true;
    # @todo system dependent
    package = pkgs.emacs-pgtk.overrideAttrs (o: {
      patches = o.patches ++ [
        ../config/emacs/patches/fix-window-role.patch
        ../config/emacs/patches/round-undecorated-frame.patch
        ../config/emacs/patches/system-appearance.patch
      ];
    });
    extraConfig = ''
      (setq user-init-file
        "${config.home.homeDirectory}/.dotfiles/config/emacs/ss2-init.el")
      (load user-init-file)
    '';
    # declare emacs packages with nix
    extraPackages = pkgs: with pkgs; [
      use-package
      magit
      company
      org-roam

      expand-region
      direnv

      # language modes
      nix-mode markdown-mode haskell-mode
    ];
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    escapeTime = 50;
    baseIndex = 1;
    terminal = "screen-256color";
    keyMode = "vi";
    extraConfig = ''
      set -g default-command  /run/current-system/sw/bin/bash
    '';
  };

  programs.git = {
    enable = true;
    userName = "softsun2";
    userEmail = "peyton.okubo13@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };

}
