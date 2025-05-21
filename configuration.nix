{ config, pkgs, ... }:
{
  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # store
  nix.settings.auto-optimise-store = true;
  # @todo: auto gc

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # bootloader
  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true; # @todo: check if I can disable this
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  networking.hostName = "buffalo";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp30s0.useDHCP = true;
  networking.interfaces.wlp33s0f3u1.useDHCP = true;

  # Select internationalisation properties.
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver = {
    enable = true;
    # @todo: fix nvidia drivers
    # videoDrivers = [ "nvidia" ];
    # screenSection = ''
    #   Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    # '';
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

  # @todo: fix sound config after updating to nix 24.11
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.extraConfig = ''
  #   unload-module module-bluetooth-policy
  #   unload-module module-bluetooth-discover
  # '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.softsun2 = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      "docker"
      "syncthing"
    ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfXndMyPax5eVS+kPXBbjC3mChBLiD/kQATMxu1QXlh peyton.okubo13@gmail.com"
    ];
  };

  # users.users.steam = {
  #   isNormalUser = true;
  #   shell = pkgs.bash;
  #   extraGroups = [ "wheel" ];
  #   openssh.authorizedKeys.keys = [
  #     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIfXndMyPax5eVS+kPXBbjC3mChBLiD/kQATMxu1QXlh peyton.okubo13@gmail.com"
  #   ];
  # };

  # fonts.fonts = with pkgs; [
  #   unifont
  #   jetbrains-mono
  #   roboto
  #   meslo-lg
  #   (nerdfonts.override { fonts = [ "JetBrainsMono" "Gohu" "Terminus" ]; })
  # ];

  # docker daemon
  # @todo: can this be moved to home manager?
  virtualisation.docker.enable = true;

  # @todo: move as much of this as possible to home.nix
  environment.systemPackages = with pkgs; [
    # @todo: can this be moved to home-manager?
    pkgs.dmenu    # dynamic menu and program launcher
    pkgs.feh      # image viewer

    # bootstrapping
    pkgs.pulsemixer
    pkgs.vim      # text editor
    pkgs.git
    pkgs.wget
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  system.stateVersion = "24.11";
}

