{ config, pkgs, lib, system, ... }:
let
  isLinux = lib.strings.hasSuffix "linux" system;
  isDarwin = lib.strings.hasSuffix "darwin" system;
in lib.mkMerge [
  {
    programs.home-manager.enable = true;
    manual.manpages.enable = false;

    # pin home manager modules/packages to the latest nix-stable channel
    home.stateVersion = "25.05";

    home.username = "softsun2";
    home.homeDirectory = (if isLinux then /home else /Users) + /softsun2;
    home.packages = with pkgs;
      [
        fontconfig
        meslo-lg
        ubuntu-sans-mono

        tldr
        tree

        ffmpeg
        yt-dlp

        qutebrowser

        # emacs extra packages
        nixfmt-classic
        graphviz
        ispell
      ] ++ lib.lists.optionals isLinux [
        st
        docker
        python3
        lshw
        dmidecode
        xclip
      ] ++ lib.lists.optionals isDarwin [ plistwatch jq alacritty ];
    fonts.fontconfig.enable = true;

    # added to .profile
    home.sessionPath = [ "${config.home.homeDirectory}/.dotfiles/bin" ];

    home.shellAliases = {
      c = "clear";
      l = "ls -l";
      ll = "ls -al";
      ".." = "cd ..";
    };

    # @todo: home-manager is for platform configurations not device
    # configurations
    services.syncthing = {
      enable = true;
      overrideDevices = true;
      overrideFolders = true;
      settings = lib.mkMerge [
        {
          options = {
            relaysEnabled = true;
            urAccepted = -1; # disable anonymous usage data collection
          };
          devices.cicada.id =
            "R5IMJUF-3UTE3HJ-DU5PMQO-GZZ5LX4-RGDBI5S-O7QD2UB-MJCZ5UZ-ZY33FAH";
          folders.org = {
            path = "${config.home.homeDirectory}/${config.home.username}/org";
            devices = [ "cicada" ] ++ lib.lists.optional isDarwin "buffalo"
              ++ lib.lists.optional isLinux "woollymammoth";
          };
        }
        (lib.mkIf isLinux {
          devices.woollymammoth.id =
            "AXQZZYW-NORHZHC-W4VEXSA-L7CNK2E-2FOUHCF-YHU6REP-34LXB4F-AI56WAF";
        })
        (lib.mkIf isDarwin {
          devices.buffalo.id =
            "DWIDPQK-OJP2OPA-DG2JHVQ-PXVK6PN-64AZ5RZ-LFN6YQJ-E4UTCFI-NRRGNQW";
        })
      ];
    };

    programs.bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = lib.mkMerge [
        {
          home-switch =
            "home-manager switch --flake ${config.home.homeDirectory}/.dotfiles";
        }
        (lib.mkIf isLinux {
          nixos-switch =
            "sudo nixos-rebuild switch --impure --flake ${config.home.homeDirectory}/.dotfiles";
        })
        (lib.mkIf isDarwin {
          darwin-switch =
            "darwin-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles";
          # window role patch support
          # https://nixos.wiki/wiki/Emacs#Window_manager_integration
          emacs =
            "${config.programs.emacs.finalPackage}/Applications/Emacs.app/Contents/MacOS/Emacs";
        })
      ];
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.firefox.enable = true;

    programs.emacs = lib.mkMerge [
      {
        enable = true;
        extraConfig = ''
          (setq user-init-file
            "${config.home.homeDirectory}/.dotfiles/config/emacs/ss2-init.el")
          (load user-init-file)
        '';
        # declare emacs packages with nix
        extraPackages = pkgs:
          with pkgs; [
            use-package
            magit
            company
            org-roam

            expand-region
            direnv

            # language modes
            nix-mode
            markdown-mode
            haskell-mode
          ];
      }
      (lib.mkIf isDarwin {
        package = pkgs.emacs-pgtk.overrideAttrs (o: {
          patches = o.patches ++ [
            ../config/emacs/patches/fix-window-role.patch
            ../config/emacs/patches/round-undecorated-frame.patch
            ../config/emacs/patches/system-appearance.patch
          ];
        });
      })
    ];

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
      extraConfig = { init = { defaultBranch = "main"; }; };
    };

  }
  (lib.mkIf isDarwin {
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
  })
  (lib.mkIf isLinux {
    home.sessionVariables = { SS2_DARK_THEME = 1; };
    home.file.".xinitrc".text = ''
      #!/bin/sh
      # background
      feh --bg-max ${config.home.homeDirectory}/Pictures/dark-bgs/IMG-5709.jpg;
      # status bar
      ${config.home.homeDirectory}/.dotfiles/bin/bar;
      # X Colors
      xrdb ${config.home.homeDirectory}/.Xresources;
      exec dwm &> ${config.home.homeDirectory}/.dwm-log.out
    '';
  })
]
