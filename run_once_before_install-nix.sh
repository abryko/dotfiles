#!/usr/bin/env bash

(
  if ! [ "$(command -v nix)" ]; then
    sh -c "(wget -qO- https://nixos.org/nix/install)" -- --no-daemon
  fi
)

(
  if [ "$(command -v nix)" ] && ! [ "$(command -v home-manager)" ]; then
    nix run home-manager/master -- init --switch --impure
  fi
)
