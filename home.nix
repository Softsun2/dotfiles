{ config, pkgs, unFree-spotify-pkgs, mypkgs, ... }:
{

  # home-manager configuration appendix:
  # https://rycee.gitlab.io/home-manager/options.html

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.libreoffice
    unFree-spotify-pkgs.spotify
    # mypkgs.spotify-adblock
    pkgs.rnix-lsp
    pkgs.yt-dlp
    pkgs.zoom-us
    # import ./modules/spotify-adblock.nix
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-python.python
      ms-python.vscode-pylance
      llvm-vs-code-extensions.vscode-clangd
      ocamllabs.ocaml-platform
      timonwong.shellcheck
      zhuangtongfa.material-theme
      jnoortheen.nix-ide
    ];
    keybindings = [
      # window movement
      {
          key = "ctrl+h";
          command = "workbench.action.focusLeftGroup";
      }
      {
          key = "ctrl+l";
          command = "workbench.action.focusRightGroup";
      }
      {
          key = "ctrl+j";
          command = "workbench.action.focusBelowGroup";
      }
      {
          key = "ctrl+k";
          command = "workbench.action.focusAboveGroup";
      }

      # diagnostics (tbd)

      # quick menu movement
      {
          key = "ctrl+j";
          command = "workbench.action.quickOpenSelectNext";
          when = "inQuickOpen";
      }
      {
          key = "ctrl+k";
          command = "workbench.action.quickOpenSelectPrevious";
          when = "inQuickOpen";
      }
      {
          key = "ctrl+c";
          command = "workbench.action.closeQuickOpen";
          when = "inQuickOpen";
      }

      # suggestions
      {
          key = "ctrl+y";
          command = "acceptSelectedSuggestion";
          when = "suggestWidgetVisible && textInputFocus";
      }
      {
          key = "ctrl+space";
          command = "toggleSuggestionDetails";
          when = "editorTextFocus && suggestWidgetVisible";
      }
      {
          key = "ctrl+j";
          command = "selectNextSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      {
          key = "ctrl+k";
          command = "selectPrevSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus";
      }
      {
          key = "ctrl+c";
          command = "editor.action.inlineSuggest.hide";
          when = "inlineSuggestionVisible";
      }

      # terminal
      {
          key = "ctrl+shift+j";
          command = "workbench.action.terminal.toggleTerminal";
          when = "terminal.active";
      }
    ];

  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    initExtra = ''
      # shell scripts
      export PATH=$HOME/.dotfiles/bin/:$PATH
      # bar script
      export PATH=$HOME/suckless/dwm/bar:$PATH
      # set vim as default editor
      EDITOR="vim"
      
      # Single line prompt
      AGKOZAK_MULTILINE=0

      # Basic auto/tab complete
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit
      #include hidden files in completions
      _comp_options+=(globdots)

      # vi mode
      bindkey -v
      export KEYTIMEOUT=2

      # Edit line in $EDITOR with ctrl-e:
      autoload edit-command-line; zle -N edit-command-line
      bindkey '^e' edit-command-line

      bindkey '^y' autosuggest-accept
    '';

    history = {
      save = 1000;
      size = 1000;
      path = "$HOME/.cache/zsh_history";
    };

    enableAutosuggestions = true;

    shellAliases = {
      ls  = "exa --icons";
      l   = "ls -l";
      ll  = "ls -la";
      c   = "clear";

      home = "vim $HOME/.dotfiles/home.nix";
      apply = ''
        nix build $HOME/.dotfiles/.#homeManagerConfigurations.softsun2.activationPackage && \
        $HOME/.dotfiles/result/activate
      '';
      flake = "vim $HOME/.dotfiles/flake.nix";
      config = "vim $HOME/.dotfiles/configuration.nix";
      rebuild = "nixos-rebuild switch --use-remote-sudo --flake $HOME/.dotfiles/.#";
    };

    plugins = [
      {
        name = "agkozak-zsh-prompt";
        file = "agkozak-zsh-prompt.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/agkozak/agkozak-zsh-prompt";
          rev = "1906ad8ef2b4019ae8a1c04d539d7a3c4bde77cb";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/zsh-users/zsh-syntax-highlighting";
          rev = "caa749d030d22168445c4cb97befd406d2828db0";
        };
      }
      {
        name = "zsh-you-should-use";
        file = "you-should-use.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/MichaelAquilina/zsh-you-should-use";
          rev = "773ae5f414b296b4100f1ab6668ecffdab795128";
        };
      }
      {
        name = "zsh-colored-man-pages";
        file = "colored-man-pages.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/ael-code/zsh-colored-man-pages";
          rev = "57bdda68e52a09075352b18fa3ca21abd31df4cb";
        };
      }
    ];
  };


  programs.git = {
    enable = true;
    userName = "softsun2";
    userEmail = "peyton.okubo13@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };


  programs.kitty = {
    enable = true;
    settings = {
      cursor = "none";
      # shell_integration = "no-cursor";
      font_family = "JetBrains Mono";
      font_size = 14;
      scrollback_lines = 5000;
      wheel_scroll_multiplier = 3;
      window_padding_width = 5;
    };
    # temp colorscheme
    extraConfig = ''
      # Base16 rug-pup - kitty color config
      # Scheme by softsun2
      background #172A25
      foreground #b7d8cf
      selection_background #b7d8cf
      selection_foreground #172A25
      url_color #d0e5e0
      active_border_color #417668
      inactive_border_color #25433b
      active_tab_background #172A25
      active_tab_foreground #b7d8cf
      inactive_tab_background #25433b
      inactive_tab_foreground #d0e5e0
      tab_bar_background #25433b

      # normal
      color0 #172A25
      color1 #B55168
      color2 #98CC92
      color3 #DCDF8E
      color4 #5E8389
      color5 #757784
      color6 #689295
      color7 #b7d8cf

      # bright
      color8 #417668
      color9 #B55168
      color10 #98CC92
      color11 #DCDF8E
      color12 #5E8389
      color13 #757784
      color14 #689295
      color15 #84bcad

      # extended base16 colors
      color16 #C28160
      color17 #C27D61
      color18 #25433b
      color19 #335d52
      color20 #d0e5e0
      color21 #9ecabe
    '';
  };


  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # find a way to get these
        # alpha-nvim

      # ui
      vim-airline
      vim-airline-themes
      nvim-web-devicons

      # languages
      vim-nix

      nvim-lspconfig

      telescope-nvim
      telescope-fzf-native-nvim
      nvim-treesitter

      # lspkind-nvim

      # nvim-cmp
      # cmp-buffer
      # cmp-path
      # cmp-nvim-lua
      # cmp-nvim-lsp
      # cmp-cmdline
      # luaSnip
      # cmp_luasnip

    ];
    # written in vimscript
    extraConfig = ''
      luafile $HOME/.dotfiles/nvim/init.lua
    '';
  };


  home.file.".xinitrc" = {
    text = "
      #!/bin/sh
      
      # background
      feh --bg-fill $HOME/Pictures/red-buck.jpg &

      # X Colors
      xrdb $HOME/.dotfiles/theme/testTheme

      # status bar
      $HOME/suckless/dwm/bar &

      # start loop
      while true; do
        dwm >/dev/null 2>&1
      done
    ";
  };

  programs.zathura.enable = true;

}
