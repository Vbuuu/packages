{
  pkgs ? import <nixpkgs> { },
}:
let
  lib = pkgs.lib;

  nested = lib.packagesFromDirectoryRecursive {
    inherit (pkgs) callPackage;
    directory = ./pkgs;
  };

  # { category = { pkg = drv; }; } -> { category-pkg = drv; }
  flattenPkgs =
    let
      op =
        acc: path: val:
        if lib.isDerivation val then
          acc // { ${builtins.concatStringsSep "-" path} = val; }
        else if builtins.isAttrs val then
          builtins.foldl' (acc: name: op acc (path ++ [ name ]) val.${name}) acc (builtins.attrNames val)
        else
          acc;
    in
    op { } [ ];

in
lib.filterAttrs (_: pkg: lib.meta.availableOn pkgs.stdenv.hostPlatform pkg) (flattenPkgs nested)
