{ config, pkgs, lib, ... }:
{
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.home-manager.enable = true;

  # pin home manager modules/packages to the latest nix-stable channel
  home.stateVersion = "24.11";

  home.username = "pokubo";
  home.homeDirectory = /home/pokubo;
  home.packages = with pkgs; [
    # dev tools
    tldr tree st ffmpeg
    sc vim

    # emacs extra packages
    pyright
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
      dot = "cd ${config.home.homeDirectory}/.dotfiles";
      home-switch = "home-manager switch --flake ${config.home.homeDirectory}/.dotfiles";
    };
    shellOptions = [ "direxpand" ];
  };

  programs.emacs = {
    enable = true;
    extraConfig = ''
      ;; inject language tool paths
      (setq ss2-languagetool-cli "${pkgs.languagetool}/share/languagetool-commandline.jar")
      (setq ss2-languagetool-java-bin "${pkgs.jre8_headless}/bin/java")

      (setq user-init-file
        "${config.home.homeDirectory}/.dotfiles/config/emacs/ss2-init.el")
      (load user-init-file)
    '';
    # declare emacs packages with nix
    extraPackages = pkgs: with pkgs; [
      use-package
      magit direnv
      expand-region

      langtool

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
    historyLimit = 20000;
    extraConfig = ''
      setw -g mode-keys vi
    '';
  };

}
