#!/bin/sh

(
if ! [ "$(command -v nix)" ]; then
	sh -c "(wget -qO- https://nixos.org/nix/install)" -- --no-daemon
fi
)

(
if [ "$(command -v nix)" ] && ! [ "$(command -v home-manager)" ]; then
  export NIX_PATH="$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}"
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update
  nix-shell '<home-manager>' -A install
fi
)
