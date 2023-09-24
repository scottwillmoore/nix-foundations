{
  inputs = {
    nix-packages.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-packages.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = {
    nix-packages,
    nixos-packages,
    ...
  }: let
    inherit (nix-packages.lib) genAttrs;

    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    forAllSystems = f: genAttrs systems (system: f system);
  in {
    inherit systems;

    nixPackages = forAllSystems (system:
      import nix-packages {
        inherit system;
        config.allowUnfree = true;
      });

    nixosPackages = forAllSystems (system:
      import nixos-packages {
        inherit system;
        config.allowUnfree = true;
      });
  };
}
