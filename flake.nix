{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-packages.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = {
    flake-parts,
    nix-packages,
    nix-systems,
    ...
  }: let
    packagesModule = {
      perSystem = {system, ...}: {
        _module.args.packages = import nix-packages {
          inherit system;
        };
      };
    };

    systemsModule = {
      systems = import nix-systems;
    };
  in {
    lib.mkFlake = inputs: module:
      flake-parts.lib.mkFlake {
        inherit inputs;
      } {
        imports = [packagesModule systemsModule module];
      };

    templates.default = {
      description = "A minimal flake that uses nix-foundations";
      path = ./templates/default;
    };
  };
}
