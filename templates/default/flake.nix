{
  inputs = {
    nix-foundations.url = "github:scottwillmoore/nix-foundations";
  };

  outputs = inputs @ {nix-foundations, ...}:
    nix-foundations.lib.mkFlake inputs ({inputs, ...}: {
      perSystem = {packages, ...}: {
        devShells.default = packages.mkShellNoCC {
          packages = [
            packages.hello
          ];
        };
      };
    });
}
