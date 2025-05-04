{
  description = "Nix Darwin Configurations";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-24.11-darwin;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixpkgs-unstable;
    darwin = {
      url = github:lnl7/nix-darwin/nix-darwin-24.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm-unstable = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, hm-unstable, ... }:
    let
      system  = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
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
      homeConfigurations.softsun2 = hm-unstable.lib.homeManagerConfiguration {
        pkgs = pkgs-unstable;
        lib = pkgs-unstable.lib;
        modules = [ ./home.nix ];
      };
    };
}
