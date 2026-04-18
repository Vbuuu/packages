{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
