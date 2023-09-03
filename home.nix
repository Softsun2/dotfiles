{ config, pkgs, ... }:
let
  typescript-language-server-fixed = pkgs.symlinkJoin {
    name = "typescript-language-server";
    paths = [ pkgs.nodePackages.typescript-language-server ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/typescript-language-server \
        --add-flags --tsserver-path=${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib/
    '';
  };
in
{
  # home-manager configuration appendix:
  # https://rycee.gitlab.io/home-manager/options.html

  programs.home-manager.enable = true;
  manual.manpages.enable = false;

  home.stateVersion = "23.05";
  home.username = "softsun2";
  home.homeDirectory = /home/softsun2;
  home.packages = [
    pkgs.gephi
    pkgs.python3
    pkgs.cider
    pkgs.vscodium
    pkgs.obs-studio
    pkgs.flameshot
    pkgs.cmatrix
    pkgs.tldr
    pkgs.teams
    pkgs.libreoffice
    pkgs.spotify
    pkgs.optifine
    pkgs.prismlauncher    # minecraft
    pkgs.yt-dlp
    pkgs.zoom-us
    pkgs.zathura
    pkgs.zip
    pkgs.unzip

    # node packages
    pkgs.nodejs
    pkgs.nodePackages.live-server

    # ocaml
    pkgs.ocaml
    pkgs.ocamlPackages.utop
  ];

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
      # AGKOZAK_MULTILINE=0

      # gd funciton
      gd () {
        cd "$(git rev-parse --show-toplevel)"/"$1"
      }

      solar-system
    '';

    shellAliases = {
      l   = "ls -l";
      ll  = "ls -la";
      c   = "clear";
      f   = "cd $(find . -type d | fzf)";
      s   = "kitty +kitten ssh";
      dotfiles = "cd ~/.dotfiles";
      school = "cd ~/school";
      "nix-search" = "firefox --new-tab 'https://search.nixos.org/packages?channel=unstable' &";

      home = "vim $HOME/.dotfiles/home.nix";
      flake = "vim $HOME/.dotfiles/flake.nix";
      config = "vim $HOME/.dotfiles/configuration.nix";
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

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    escapeTime = 50;
    terminal = "screen-256color";
    extraConfig = ''
      set-option -g status-position bottom
      set -g status-bg black 
      set -g status-fg blue
    '';
  };

  programs.kitty = {
    enable = true;
    settings = {
      cursor = "none";
      allow_remote_control = true;
      font_family = "Meslo";
      font_size = 10;
      scrollback_lines = 5000;
      wheel_scroll_multiplier = 3;
      window_padding_width = 10;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
    extraConfig = ''
      # runtime colors
      include ~/.dotfiles/theme/kitty/theme.conf

      # minimize functionality (using tmux instead)
      # clear_all_shortcuts yes
      # clear_all_mouse_actions yes

      # the few shortcuts I actually want
      # map ctrl+equal change_font_size all +1.0
      # map ctrl+minus change_font_size all -1.0
      # map ctrl+shift+c copy_to_clipboard
      # map ctrl+shift+v paste_from_clipoard
      # be able to interact with links in some way
    '';
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;

    # written in vim script
    extraConfig = ''
      luafile $HOME/.dotfiles/config/nvim/lua/init.lua
    '';

  plugins = [

      ( pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
          tree-sitter-lua
          tree-sitter-bash
          tree-sitter-c
          tree-sitter-cpp
          tree-sitter-make
          tree-sitter-python
          tree-sitter-html
          tree-sitter-css
          tree-sitter-json
          tree-sitter-ocaml
          tree-sitter-javascript
        ]
      ))

      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.gitsigns-nvim
      pkgs.vimPlugins.vim-illuminate

      pkgs.vimPlugins.nvim-lspconfig          # lsp
      pkgs.vimPlugins.lspsaga-nvim            # better lsp ui

      pkgs.vimPlugins.telescope-nvim          # integrated fuzzy finder
      pkgs.vimPlugins.plenary-nvim

      pkgs.vimPlugins.harpoon                 # Tagged files

      pkgs.vimPlugins.indent-blankline-nvim
      pkgs.vimPlugins.vim-nix                 # nix

      pkgs.vimPlugins.nvim-navic

      pkgs.vimPlugins.nvim-autopairs
      pkgs.vimPlugins.nvim-ts-autotag
      pkgs.vimPlugins.vim-prettier

      pkgs.vimPlugins.luasnip                 # snippet engine
      pkgs.vimPlugins.friendly-snippets       # more snippets

      pkgs.vimPlugins.nvim-cmp                # completions
      pkgs.vimPlugins.cmp-buffer              # completion source: buffer
      pkgs.vimPlugins.cmp-path                # completion source: file path
      pkgs.vimPlugins.cmp-nvim-lua            # completion source: nvim config aware lua
      pkgs.vimPlugins.cmp-nvim-lsp            # completion source: lsp
      pkgs.vimPlugins.cmp-cmdline             # completion source: cmdline
      pkgs.vimPlugins.cmp_luasnip             # completion source: luasnip snippets
      pkgs.vimPlugins.lspkind-nvim            # pictograms for completion suggestions
      pkgs.vimPlugins.colorizer               # color name highlighter
    ];

    extraPackages = with pkgs; [
      # language servers
      rnix-lsp
      sumneko-lua-language-server
      nodePackages.pyright
      nodePackages.vscode-langservers-extracted
      nodePackages.typescript
      nodePackages.eslint
      typescript-language-server-fixed
      # ocamlPackages.ocaml-lsp
      rPackages.languageserver
      ccls
      ltex-ls

      # telescope depency
      ripgrep
    ];
  };

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

}
