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
      bruh = import (builtins.fetchGit {
        # Descriptive name to make the store path easier to identify                
        name = "my-old-revision";                                                 
        url = "https://github.com/NixOS/nixpkgs/";                       
        ref = "refs/heads/nixpkgs-unstable";                     
        rev = "2c162d49cd5b979eb66ff1653aecaeaa01690fcc";                                           
      }) {};                                                                           
      spotify = bruh.spotify;
    in
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (self: super: {
            spotify = super.spotify.overrideAttrs (o: {
              src = spotify;
            });
          })
        ];
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      
      # could wrap this later
      homeManagerConfigurations = {
        softsun2 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
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
