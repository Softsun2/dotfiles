{ config, pkgs, ... }: {
  # nix-darwin options: https://daiderd.com/nix-darwin/manual/index.html
  # https://github.com/LnL7/nix-darwin/blob/master/tests/system-defaults-write.nix
  # system packages
  environment.systemPackages = with pkgs; [ vim git ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.enable = true;

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

  system.primaryUser = "softsun2";
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
    skhd = import ../config/nix/skhd.nix {
      enable = true;
      package = pkgs.skhd;
    };
    yabai = import ../config/nix/yabai.nix {
      enable = true;
      package = pkgs.yabai;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
