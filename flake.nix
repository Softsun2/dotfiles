{
  inputs = {

    nixpkgs.url = github:nixos/nixpkgs/nixos-24.05;
    home-manager = {
      url = github:nix-community/home-manager/release-24.05;
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

      rosetta-pkgs = nixpkgs.legacyPackages.${rosetta};

    in {

      homeConfigurations.pokubo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        lib = pkgs.lib;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit rosetta-pkgs; };
      };

    };
}
