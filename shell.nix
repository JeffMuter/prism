#! /usr/bin/env nix-shell
{ pkgs ? import <nixpkgs> { 
    config = { 
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  }
}:
let
  # Import unstable channel for claude-code
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [ 
    go_1_23
    goose
  ] ++ [
    unstable.claude-code
  ];
  # Allow unsafe/experimental features
  NIX_CONFIG = ''
    experimental-features = nix-command flakes
    allow-import-from-derivation = true
  '';
}
