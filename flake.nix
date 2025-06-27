{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
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
      nixosConfigurations.buffalo = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "nvidia-x11"
              "nvidia-settings"
            ];
        };
        modules = [ ./modules/configuration-buffalo.nix ];
      };
      darwinConfigurations.woollymammoth = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./modules/configuration-woollymammoth.nix ];
      };
      packages = genSystemAttrs (system: {
        homeConfigurations.softsun2 = hm.lib.homeManagerConfiguration rec {
          pkgs = nixpkgs.legacyPackages."${system}";
          lib = pkgs.lib;
          modules = [ ./modules/home.nix ];
          extraSpecialArgs = { inherit system; };
        };
      });
    };
}
