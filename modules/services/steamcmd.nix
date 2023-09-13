{ lib, pkgs, options, config, ... }:

# Home manager steamcmd service

with lib;

let
  cfg = config.services.steamcmd;
in {

  options.services.steamcmd = {
    enable = mkEnableOption "steamcmd agent";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.steamcmd;
      defaultText = literalExpression "pkgs.steamcmd";
      description = mdDoc "The steamcmd package to use.";
    };
    
    # servers
      # app id
      # name
      # server settings
      # plugins
      # startup and persistencs
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    systemd.user.services.steamcmd = {
      Service = {
        ExecStart = "echo \"steamcmd service started\"";
        Restart = "always";
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ softsun2 ];
}
