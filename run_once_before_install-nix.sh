#!/usr/bin/env bash

(
  if ! [ "$(command -v nix)" ]; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  fi
)

(
  if [ "$(command -v nix)" ] && ! [ "$(command -v home-manager)" ]; then
    nix run home-manager/master -- init --switch --impure
  fi
)
