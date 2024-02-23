{
  inputs = {

    nixpkgs.url = github:nixos/nixpkgs/nixos-24.11;
    home-manager = {
      url = github:nix-community/home-manager/release-24.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in {

      homeConfigurations.pokubo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        lib = pkgs.lib;
        modules = [ ./home.nix ];
      };

    };
}
