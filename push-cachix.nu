#!/usr/bin/env nu

def main [--impure, --arm64, --x64] {
  let all_systems = ["x86_64-linux", "aarch64-linux"]
  let systems = if $arm64 and not $x64 {
    ["aarch64-linux"]
  } else if $x64 and not $arm64 {
    ["x86_64-linux"]
  } else {
    $all_systems
  }
  let packages = (nix flake show --json --all-systems --accept-flake-config | from json | get packages)

  let targets = ($systems | each { |sys|
    $packages | get -o $sys | default {} | columns | each { $"#packages.($sys).($in)" }
  } | flatten)

  let nix_args = if $impure { ["--impure"] } else { [] }

  nix build --no-link --print-out-paths --accept-flake-config ...$nix_args ...$targets | cachix push vbuuu
}
