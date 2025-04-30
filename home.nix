{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  home.stateVersion = "24.11";

  home.username = "softsun2";
  home.homeDirectory = /home/softsun2;
  home.packages = with pkgs; [
    openvpn tcpdump tailscale syncthing

    python3 tldr alacritty

    firefox discord

    jq tree fzf docker lshw dmidecode xclip
  ];

  home.file.".xinitrc" = {
    text = "
      #!/bin/sh

      # screens
      screens &

      # background
      feh --bg-fill $HOME/Pictures/1.JPG &

      # X Colors
      xrdb $HOME/.dotfiles/theme/xcolors-dwm &

      # status bar
      $HOME/suckless/dwm/bar &

      # start loop
      while true; do
        dwm >/dev/null 2>&1
      done
    ";
  };

  # @todo: config alacritty
  home.file."${config.xdg.configHome}/alacritty.toml".text = ''
  '';

  home.sessionPath = [
    "${config.home.homeDirectory}/.dotfiles/bin"
  ];

  home.shellAliases = {
    c = "clear";
    l = "ls -l";
    ll = "ls -al";
    ".." = "cd ..";
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
