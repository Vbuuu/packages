{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  nixConfig = {
    extra-substituters = [
      "https://vbuuu.cachix.org"
    ];

    extra-trusted-public-keys = [
      "vbuuu.cachix.org-1:jf97r2/bHQvuifjPM0YmelhTXrEvLC0UpS9+jPuwCnw="
    ];
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;

          config.allowUnfreePredicate =
            pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "cheat-engine"
            ];
        };
      in
      {
        packages = import ./. { inherit pkgs; };

        devShells.default = pkgs.mkShell {
          name = "packages";

          packages = with pkgs; [
            treefmt
            nixfmt
            nix-update
            cachix
          ];
        };
      }
    ));
}
