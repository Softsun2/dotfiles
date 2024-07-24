{ config, pkgs, rosetta-pkgs, lib, ... }:
{
  # nix = {
  #   package = pkgs.nix;
  #   settings.experimental-features = [ "nix-command" "flakes" ];
  # };

  programs.home-manager.enable = true;

  # pin home manager modules/packages to the latest nix-stable channel
  home.stateVersion = "24.05";
  
  home.username = "pokubo";
  home.homeDirectory = /home/pokubo;
  home.packages = with pkgs; [
    # dev tools
    tldr tree
  ];

  home.shellAliases = {
    c = "clear";
    l = "ls -l";
    ll = "ls -al";
    ".." = "cd ..";
    fss2 = ''
      dest=$(find -d ${config.home.homeDirectory}/${config.home.username} | fzf) \
      && cd "$dest"
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      # ${config.home.homeDirectory}/.dotfiles/bin/solar-system
      ss2-prompt () {
          PS1="\h.\u$ "
      }
    '';
    sessionVariables = {
      PROMPT_COMMAND = "ss2-prompt";
    };
    shellAliases = {
      dot = "cd ${config.home.homeDirectory}/.dotfiles";
      home-switch = "home-manager switch --flake ${config.home.homeDirectory}/.dotfiles";
    };
  };

  programs.direnv = { 
    enable = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      -- source my config
      vim.opt.runtimepath:prepend("${config.home.homeDirectory}/.dotfiles/config/nvim")
      require("ss2-init")
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig # community maintained lsp configurations
      lspkind-nvim # lsp suggestion pictograms
      lsp-overloads-nvim

      nvim-cmp # completion engine
      cmp-nvim-lsp # lsp completion source
      cmp-path # file system completion source
      cmp-nvim-lua # lua (for nvim) completion source
      # cmp-spell/cmp-dictionary
      luasnip

      # treesitter with grammars
      (nvim-treesitter.withPlugins (g: with g; [
        nix
        lua
        bash
        c
        cpp
        haskell
        markdown
        markdown-inline
        regex
      ]))

      vim-nix # nix
      gitsigns-nvim # gutter git info
      telescope-nvim # integrated fuzzy finder
      vim-devicons # stupid icon dependency
    ];
    extraPackages = with pkgs; [
      sumneko-lua-language-server
      ripgrep
    ];
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
      meow
      ef-themes
      eglot
      company
      org-roam
      expand-region
      direnv

      # language modes
      nix-mode
      markdown-mode
      haskell-mode
      tuareg # ocaml mode
    ];
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    escapeTime = 50;
    baseIndex = 1;
    terminal = "screen-256color";
    extraConfig = ''
      setw -g mode-keys vi
    '';
  };

}
