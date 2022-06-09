{
  description = "NixOS System Configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        # overlays would go here I think?
      };
      lib = nixpkgs.lib;
    in {
      
      # could wrap this later
      homeManagerConfigurations = {
        softsun2 = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "softsun2";
          homeDirectory = "/home/softsun2";
          configuration = {
            imports = [ ./home.nix ];
          };
        };
      };
      
      nixosConfigurations = {
        buffalo = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [ ./configuration.nix ];
        };
      };

    };
}
