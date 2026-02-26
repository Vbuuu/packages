#!/usr/bin/env nu

def main [] {
  let systems = ["x86_64-linux", "aarch64-linux"]
  let flake = (nix flake show --json --all-systems | from json | get packages)
  let targets = ($systems | each { |sys|
    let pkgs = ($flake | get $sys | columns)
    $pkgs | each { $sys + "." + $in } | each { ".#packages." + $in }
  } | flatten)

  nix build --no-link --print-out-paths ...$targets | cachix push vbuuu
}
