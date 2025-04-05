{
  description = "Nix Darwin Configurations";

  inputs = {

    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-24.11-darwin;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixpkgs-unstable;

    darwin = {
      url = github:lnl7/nix-darwin/nix-darwin-24.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager/release-24.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, home-manager, ... }:
    let
      
      system  = "aarch64-darwin";
      rosetta = "x86_64-darwin";
      
      # yabai usually breaks every MacOS update; pull in yabai updates asap
      yabai-unstable-overlay = (_: _: {
        yabai = nixpkgs-unstable.legacyPackages.${system}.yabai;
      });

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ yabai-unstable-overlay ];
        config.allowUnfree = true;
      };

      rosetta-pkgs = nixpkgs.legacyPackages.${rosetta};

    in {

      homeConfigurations.softsun2 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        lib = pkgs.lib;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit rosetta-pkgs; };
      };

      darwinConfigurations = {
        woollymammoth = darwin.lib.darwinSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./configuration.nix ];
        };
      };

    };
}
