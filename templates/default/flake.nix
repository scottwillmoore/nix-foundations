{
  inputs = {
    nix-foundations.url = "github:scottwillmoore/nix-foundations";
  };

  outputs = inputs @ {nix-foundations, ...}:
    nix-foundations.mkFlake inputs ({inputs, ...}: {
      perSystem = {packages, ...}: {
        devShells.default = packages.mkShellNoCC {
          packages = [
            packages.hello
          ];
        };
      };
    });
}
