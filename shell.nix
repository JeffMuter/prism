
#! /usr/bin/env nix-shell
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [ 
    go_1_23
    sqlc 
    goose
    ];
}
