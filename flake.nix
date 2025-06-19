{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    # nixpkgs.url = github:nixos/nixpkgs/nixos-24.11;
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, hm, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      genSystemAttrs = nixpkgs.lib.attrsets.genAttrs systems;
    in {
      nixosConfigurations.buffalo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./modules/configuration-buffalo.nix ];
      };
      darwinConfigurations.woollymammoth = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./modules/configuration-darwin.nix ];
      };
      packages = genSystemAttrs (system: {
        homeConfigurations.softsun2 = hm.lib.homeManagerConfiguration rec {
          pkgs = nixpkgs.legacyPackages."${system}";
          lib = pkgs.lib;
          modules = [ ./modules/home.nix ];
        };
      });
    };
}
