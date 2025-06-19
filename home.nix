{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  home.stateVersion = "24.11";

  home.username = "softsun2";
  home.homeDirectory = /home/softsun2;
  home.packages = with pkgs; [
    meslo-lg ubuntu-sans-mono
    python3 tldr
    st jq tree fzf docker lshw dmidecode xclip
    qutebrowser
    nixfmt-classic
    ispell
  ];
  fonts.fontconfig.enable = true;

  home.file.".xinitrc" = {
    text = "
      #!/bin/sh

      # background
      feh --bg-max ${config.home.homeDirectory}/Pictures/dark-bgs/IMG-5709.jpg;

      # status bar
      ${config.home.homeDirectory}/.dotfiles/bin/bar;

      # X Colors
      xrdb ${config.home.homeDirectory}/.Xresources;

      exec dwm &> ${config.home.homeDirectory}/.dwm-log.out
    ";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.dotfiles/bin"
  ];

  home.sessionVariables = {
    SS2_DARK_THEME = 1;
  };

  home.shellAliases = {
    c = "clear";
    l = "ls -l";
    ll = "ls -al";
    ".." = "cd ..";
  };

  services.syncthing = {
    enable = true;
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      options.relaysEnabled = true;
      options.urAccepted = -1; # disable anonymous usage data collection
      devices.woollymammoth.id = "AXQZZYW-NORHZHC-W4VEXSA-L7CNK2E-2FOUHCF-YHU6REP-34LXB4F-AI56WAF";
      devices.cicada.id = "R5IMJUF-3UTE3HJ-DU5PMQO-GZZ5LX4-RGDBI5S-O7QD2UB-MJCZ5UZ-ZY33FAH";
      folders.org = {
        path = "${config.home.homeDirectory}/${config.home.username}/org";
        devices = [ "woollymammoth" "cicada" ];
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      home-switch = "home-manager switch --flake ${config.home.homeDirectory}/.dotfiles";
      nixos-switch = "sudo nixos-rebuild switch --impure --flake ${config.home.homeDirectory}/.dotfiles";
    };
  };

  programs.git = {
    enable = true;
    userName = "softsun2";
    userEmail = "peyton.okubo13@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };

  programs.emacs = {
    enable = true;
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
      expand-region
      direnv

      # language modes
      nix-mode
      markdown-mode
      haskell-mode
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    escapeTime = 50;
    terminal = "screen-256color";
    extraConfig = ''
      setw -g mode-keys vi
      set-option -g status-position bottom
      set -g status-bg black
      set -g status-fg blue
    '';
  };

}
