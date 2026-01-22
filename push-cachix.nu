#!/usr/bin/env nu

def main [] {
  let pkgs = (nix flake show --json --all-systems | from json | get packages | get "x86_64-linux" | columns)
  let targets = ($pkgs | each { ".#" + $in })

  nix build --no-link --print-out-paths ...$targets | cachix push vbuuu
}
