{
  pkgs ? import <nixpkgs> { },
}:
(builtins.mapAttrs (
  name: type:
  let
    package = pkgs.callPackage ./pkgs/${name} { };
  in
  package
) (builtins.readDir ./pkgs))
