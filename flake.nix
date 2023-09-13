{
  description = "NixOS and User Configurations";

  inputs = {
    
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;

    home-manager = {
      url = github:nix-community/home-manager/release-23.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
  let

    system = "x86_64-linux";
    # nixpkgs
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  in {

      homeConfigurations.softsun2 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        lib = pkgs.lib;
        modules = [ ./home.nix ];
      };
      
      nixosConfigurations = {
        buffalo = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };

  };
}
