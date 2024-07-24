{ config, pkgs, rosetta-pkgs, lib, ... }:
{
  manual.manpages.enable = false;
  programs.home-manager.enable = true;

  # pin home manager modules/packages to the latest nix-stable channel
  home.stateVersion = "24.05";

 home.username = "softsun2";
  home.homeDirectory = /Users/softsun2;
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hasklig" ]; })

    # media
    ffmpeg
    yt-dlp

    # dev tools
    tldr
    tree
    plistwatch
    jq

    # emacs extra packages
    nixfmt
  ];

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

  home.file."${config.xdg.configHome}/alacritty.toml".text = ''
    [shell]
      program = "/run/current-system/sw/bin/bash"
      args = ["--login"]
  '';

  # added to .profile
  home.sessionPath = [
    "${config.home.homeDirectory}/.dotfiles/bin"
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
      ${config.home.homeDirectory}/.dotfiles/bin/solar-system
      ss2-prompt () {
          PS1="\h.\u$ "
      }
    '';
    sessionVariables = {
      SHELL = "/run/current-system/sw/bin/bash";
      PROMPT_COMMAND = "ss2-prompt";
    };
    shellAliases = {
      dot = "cd ${config.home.homeDirectory}/.dotfiles";
      home-switch = "home-manager switch --flake ${config.home.homeDirectory}/.dotfiles";
      darwin-switch = "darwin-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles";
      # window role patch support
      # https://nixos.wiki/wiki/Emacs#Window_manager_integration
      emacs = "${config.programs.emacs.finalPackage}/Applications/Emacs.app/Contents/MacOS/Emacs";
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
    defaultEditor = true;
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
    package = pkgs.emacs29-pgtk.overrideAttrs (o: {
      patches = o.patches ++ [
        ./config/emacs/patches/fix-window-role.patch
        ./config/emacs/patches/round-undecorated-frame.patch
        ./config/emacs/patches/system-appearance.patch
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

  programs.git = {
    enable = true;
    userName = "softsun2";
    userEmail = "peyton.okubo13@gmail.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "--color=16" ];
  };

}
