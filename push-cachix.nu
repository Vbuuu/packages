#!/usr/bin/env nu

def main [--impure] {
  let systems = ["x86_64-linux", "aarch64-linux"]
  let packages = (nix flake show --json --all-systems | from json | get packages)

  let targets = ($systems | each { |sys|
    $packages | get -o $sys | default {} | columns | each { $"#packages.($sys).($in)" }
  } | flatten)

  let nix_args = if $impure { ["--impure"] } else { [] }

  nix build --no-link --print-out-paths ...$nix_args ...$targets | cachix push vbuuu
}
