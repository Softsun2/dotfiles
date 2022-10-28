{
  config,
  pkgs,
  mypkgs,
  unFree-spotify-pkgs,
  ...
}:
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

  home.packages = [
    pkgs.flameshot
    pkgs.cmatrix
    pkgs.tldr
    pkgs.teams
    pkgs.libreoffice
    unFree-spotify-pkgs.spotify
    pkgs.minecraft
    pkgs.yt-dlp
    pkgs.zoom-us
    pkgs.zathura
    mypkgs.flavours
    pkgs.zip
    pkgs.unzip

    # node packages
    pkgs.nodejs
    pkgs.nodePackages.live-server

    # ocaml
    pkgs.ocaml
    pkgs.ocamlPackages.utop

    # mypkgs.spotify-adblock
    # import ./modules/spotify-adblock.nix
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

      # falvours config location
      export FLAVOURS_CONFIG_FILE=$HOME/.dotfiles/config/flavours/config.toml

      bindkey '^y' autosuggest-accept
      bindkey -s '^f' 'f\n'

      # gd funciton
      gd () {
        cd "$(git rev-parse --show-toplevel)"/"$1"
      }

      solar-system
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
      f   = "cd $(find . -type d | fzf)";
      s   = "kitty +kitten ssh";
      dotfiles = "cd ~/.dotfiles";
      school = "cd ~/school";

      shell = "nix-shell";
      home = "vim $HOME/.dotfiles/home.nix";
      build-home= "nix build -o ~/.dotfiles/result ~/.dotfiles/.#homeManagerConfigurations.softsun2.activationPackage && ~/.dotfiles/result/activate";
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
    # plugins = with pkgs; [
    #   tmuxPlugins.cpu
    #   {
    #     plugin = tmuxPlugins.resurrect;
    #     extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    #   }
    #   {
    #     plugin = tmuxPlugins.continuum;
    #     extraConfig = ''
    #       set -g @continuum-restore 'on'
    #       set -g @continuum-save-interval '10' #minutes
    #     '';
    #   }
    # ];
  };

  programs.kitty = {
    enable = true;
    settings = {
      cursor = "none";
      allow_remote_control = true;
      font_family = "JetBrains Mono";
      font_size = 12;
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

    plugins = with pkgs.vimPlugins; [
      ( nvim-treesitter.withPlugins (
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
        ]
      ))

      nvim-lspconfig          # lsp

      telescope-nvim          # integrated fuzzy finder
      telescope-fzf-native-nvim # idek
      plenary-nvim            # idek

      harpoon
      nvim-tree-lua           # file tree
      vim-floaterm            # floating terminal

      nvim-web-devicons       # dev icons
      indent-blankline-nvim   # indent lines
      vim-nix                 # nix
      colorizer

      luasnip                 # snippet engine
      friendly-snippets       # more snippets!!

      nvim-base16             # base16 color schemes w/ lsp & treesitter support

      nvim-cmp                # completions
      cmp-buffer              # completion source: buffer
      cmp-path                # completion source: file path
      cmp-nvim-lua            # completion source: nvim config aware lua
      cmp-nvim-lsp            # completion source: lsp
      cmp-cmdline             # completion source: cmdline
      cmp_luasnip             # completion source: luasnip snippets
      lspkind-nvim            # pictograms for completion suggestions
    ]; 

    extraPackages = with pkgs; [
      # language servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      rnix-lsp                                      # nix
      sumneko-lua-language-server                   # lua
      nodePackages.pyright                          # python
      nodePackages.vscode-langservers-extracted     # ...
      typescript-language-server-fixed              # typescript/javascript
      ocamlPackages.ocaml-lsp                       # ocaml
      ccls                                          # c/c++

      # dependencies
      ripgrep
      nodePackages.typescript
    ];
  };

  home.file.".xinitrc" = {
    text = "
      #!/bin/sh

      # screens
      xrandr --output DP-0 --primary --mode 1920x1080 --rate 144
      xrandr --output DVI-D-1 --mode 1024x768 --rate 85 --right-of DP-0
      
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

}
