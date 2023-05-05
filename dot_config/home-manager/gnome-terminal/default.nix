# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/terminal/legacy" = {
      default-show-menubar = false;
      schema-version = 3;
      theme-variant = "dark";
    };

    "org/gnome/terminal/legacy/keybindings" = {
      move-tab-left = "<Primary><Shift>Left";
      move-tab-right = "<Primary><Shift>Right";
      next-tab = "<Primary>Tab";
      prev-tab = "<Primary><Shift>Tab";
    };

    "org/gnome/terminal/legacy/profiles:" = {
      default = "4dff060d-cd00-450a-888f-309315596f9b";
      list = [ "4dff060d-cd00-450a-888f-309315596f9b" ];
    };

    "org/gnome/terminal/legacy/profiles:/:4dff060d-cd00-450a-888f-309315596f9b" = {
      allow-bold = true;
      audible-bell = true;
      background-color = "#000000";
      backspace-binding = "ascii-delete";
      bold-color-same-as-fg = true;
      bold-is-bright = true;
      cursor-blink-mode = "on";
      cursor-colors-set = false;
      cursor-shape = "block";
      custom-command = "zellij";
      delete-binding = "delete-sequence";
      font = "BitstreamVeraSansMono Nerd Font Mono 11";
      foreground-color = "#ffffff";
      highlight-colors-set = false;
      login-shell = false;
      palette = [ "#2e3436" "#cc0000" "#4e9a06" "#c4a000" "#3465a4" "#75507b" "#06989a" "#d3d7cf" "#555753" "#ef2929" "#8ae234" "#fce94f" "#729fcf" "#ad7fa8" "#34e2e2" "#eeeeec" ];
      scroll-on-output = false;
      scrollback-lines = 1000000;
      scrollbar-policy = "always";
      use-custom-command = false;
      use-system-font = false;
      use-theme-colors = false;
      visible-name = "default";
    };

  };
}
