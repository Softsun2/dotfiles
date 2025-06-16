{ config, pkgs, ... }:
{
  # nix-darwin options: https://daiderd.com/nix-darwin/manual/index.html
  # https://github.com/LnL7/nix-darwin/blob/master/tests/system-defaults-write.nix
  # system packages
  environment.systemPackages = with pkgs; [ vim git ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    extra-platforms = aarch64-darwin x86_64-darwin
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.gc = {
    automatic = true;
    # This isn't documented well
    # https://crontab.guru has close to the same semantics
    interval = {
      # gc every monday at 4:15 AM
      Weekday = 1;
      Hour = 4;
      Minute = 15;
    };
    options = "--delete-older-than 1w";
  };

  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/activation-scripts.nix:
  # A set of shell script fragments that are executed when a NixOS system configuration is activated.
  system.activationScripts.postActivation.text = ''
    # same as "Prevent your Mac from automatically sleeping when the display is off"
    # means that require password after sleep is not triggered
    sudo pmset -c sleep 0
    # disable reboot sound effect
    sudo nvram SystemAudioVolume=" "
  '';

  system.defaults = import ../config/nix/defaults.nix;

  # https://developer.apple.com/library/archive/technotes/tn2450/_index.html#//apple_ref/doc/uid/DTS40017618-CH1-KEY_TABLE_USAGES
  # python3 -c '(lambda srcId, dstId: print(0x700000000^srcId, 0x700000000^dstId))'
  # hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000065,"HIDKeyboardModifierMappingDst":0x7000000E7}]}'
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
    userKeyMapping = [
      # remap left control to escape
      ({
        # for example swap left alt and left mod key:
        # python3 -c '(lambda srcId, dstId: print(0x700000000^srcId, 0x700000000^dstId))(0xE2, 0xE3)'
        HIDKeyboardModifierMappingSrc = 30064771296;
        HIDKeyboardModifierMappingDst = 30064771113;
      })
    ];
  };

  # services
  services = {
    skhd = import ../config/nix/skhd.nix { enable = true; package = pkgs.skhd; };
    yabai = import ../config/nix/yabai.nix { enable = true; package = pkgs.yabai; };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global = {
      brewfile = true;
      lockfiles = false;
    };
    taps = [
      "homebrew/cask-versions"
    ];
    casks = [ "vial" "alacritty" "firefox" "obs" "olive" ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
