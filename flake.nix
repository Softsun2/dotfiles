{
  description = "NixOS System Configurations";

  inputs = {
    
    nixpkgs.url = "nixpkgs/nixos-unstable";

    mynixpkgs.url = "github:Softsun2/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ {
    nixpkgs,
    mynixpkgs,
    home-manager,
    ...
  }:
    let
      system = "x86_64-linux";

      # nixpkgs
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # mynixpkgs
      mypkgs = import mynixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      homeManagerConfigurations = {
        softsun2 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit mypkgs;
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

      homeConfigurations.softsun2 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        lib = pkgs.lib;
        modules = [ ./home.nix ];
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
