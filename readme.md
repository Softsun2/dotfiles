# Nix Darwin on Apple Silicon

### Goals

-   Portable development environment
	- [ ] Merge NixOS config into this repo
	- [ ] Abstract non-Nix dependent inputs, such as emacs packages
-   Archivable development environment
-   Deep understanding of development tools
-   Effective use of development tools
-   Prefer stable channels

### Implementation

-   Non-gui packages configure by nix-darwin and home-manager where appropriate
-   Gui packages sourced from brew, managed by nix-darwin
-   [X] Isolate user data from program/"uncontrolled" areas of my home
        directory ([See notes](./notes/nix-darwin-xdg.md))
-   [ ] Stable channels (depending on unstable for syncthing
        configuration atm)
-   [X] Nix-darwin store optimization
-   [ ] Home-manager store optimization
-   [ ] backups
-   [ ] browser experience/privacy

## Notes

-   [Nix-darwin system defaults (preferences)](./notes/nix-darwin-system-defaults.md)
-   [Home Manager and Home Dir](./notes/nix-darwin-xdg.md)
