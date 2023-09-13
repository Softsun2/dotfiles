{ config, pkgs, ... }:
{

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  # grub support
  # make sure you give grub the highest boot priority in your BIOS
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  networking.hostName = "buffalo"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp30s0.useDHCP = true;
  networking.interfaces.wlp33s0f3u1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    '';
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
  };

  # FIXME: After I am satisfied with a working version of dwm
  # make this overlay a flake input
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/softsun2/suckless/dwm; });
    })
  ];

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraConfig = ''
    unload-module module-bluetooth-policy
    unload-module module-bluetooth-discover
  '';

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.softsun2 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfXndMyPax5eVS+kPXBbjC3mChBLiD/kQATMxu1QXlh peyton.okubo13@gmail.com"
    ];
  };

  fonts.fonts = with pkgs; [
    unifont
    jetbrains-mono
    roboto
    meslo-lg
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Gohu" "Terminus" ]; })
  ];

  # docker daemon
  virtualisation.docker.enable = true;

  environment.pathsToLink = [ "/share/zsh" ];



  # List packages installed in system profile. To search, run:
  environment.systemPackages = [

    # Desktop 
    pkgs.dwm      # window manager
    pkgs.dmenu    # dynamic menu and program launcher
    pkgs.feh      # image viewer

    # Apps
    pkgs.firefox
    pkgs.discord

    # util
    pkgs.pulsemixer
    pkgs.vim      # text editor
    pkgs.emacs
    pkgs.zsh      # z shell
    pkgs.git
    pkgs.wget
    pkgs.tree
    pkgs.fzf      # fuzzy finder
    pkgs.docker
    pkgs.lshw
    pkgs.dmidecode
    pkgs.xclip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.05"; # Did you read the comment?

}

