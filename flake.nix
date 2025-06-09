{
  description = "Nix Darwin Configurations";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-25.05-darwin;
    darwin = {
      url = github:lnl7/nix-darwin/nix-darwin-25.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm = {
      url = github:nix-community/home-manager/release-25.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, hm, ... }:
    let
      system  = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      darwinConfigurations = {
        woollymammoth = darwin.lib.darwinSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations.softsun2 = hm.lib.homeManagerConfiguration {
        inherit pkgs;
        lib = pkgs.lib;
        modules = [ ./home.nix ];
      };
    };
}
