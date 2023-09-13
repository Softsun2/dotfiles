{ lib, pkgs, options, config, ... }:

# Home manager steamcmd service

# https://nixos.org/manual/nixos/stable/#sec-option-declarations

# Type checking example:
# type = types.addCheck types.int (x: x >= 0 && x <= 255);

with lib;

let
  cfg = config.services.steamcmd;
in {

  options.services.steamcmd = {
    enable = mkEnableOption "steamcmd agent";

    # not sure if this is necessary?
    package = mkOption {
      type = types.package;
      default = pkgs.steamcmd;
      defaultText = literalExpression "pkgs.steamcmd";
      description = mdDoc "The steamcmd package to use.";
    };
    
    dedicatedServers = mkOption {
      description = "Steamcmd servers";
      type = with types; attrsOf (submodule {
        options = {
          appId = mkOption {
            type = types.int;
          };
          validate = mkOption {
            type = types.bool;
            default = false;
          };
        };
      });
    };

    # servers
      # app id
      # validate
      # server settings
      # plugins
      # startup
      # auto-updating
      # persistence
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # systemd.user.services.steamcmd = {
    #   Service = {
    #     ExecStart = "echo \"steamcmd service started\"";
    #     Restart = "always";
    #   };
    # };

  };

  meta.maintainers = with maintainers; [ softsun2 ];
}
