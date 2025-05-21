{
  description = "NixOS and User Configurations";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-24.11;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixpkgs-unstable;
    hm-unstable = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, hm-unstable, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      buffalo = nixpkgs.lib.nixosSystem {
        inherit system;
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
