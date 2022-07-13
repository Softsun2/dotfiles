{
  description = "NixOS System Configurations";

  inputs = {
    
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # need this version of spotify for nixos
    spotify-pkgs.url = "https://github.com/NixOS/nixpkgs/archive/2c162d49cd5b979eb66ff1653aecaeaa01690fcc.tar.gz";

  };

  outputs = inputs @ { nixpkgs, home-manager, spotify-pkgs, ... }:
    let
      system = "x86_64-linux";

      # nixpkgs
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      # contains unix friendly spotify package
      unFree-spotify-pkgs = import spotify-pkgs {
        inherit system;
        config.allowUnfree = true;
      };
      # my packages
      mypkgs = import ./pkgs pkgs.callPackage {};

      lib = nixpkgs.lib;
    in {
      # could wrap this later
      homeManagerConfigurations = {
        softsun2 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit unFree-spotify-pkgs;
            # inherit mypkgs;
          };
          modules = [
            ./home.nix
            {
              home = {
                username = "softsun2";
                homeDirectory = "/home/softsun2";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };
      
      nixosConfigurations = {
        buffalo = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./configuration.nix
          ];
        };
      };

    };
}
