# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "com/gexperts/Tilix" = {
      enable-wide-handle = false;
      paste-strip-trailing-whitespace = true;
      prompt-on-close = true;
      prompt-on-delete-profile = true;
      quake-specific-monitor = 0;
      terminal-title-show-when-single = true;
      terminal-title-style = "small";
      theme-variant = "dark";
      use-tabs = true;
    };

    "com/gexperts/Tilix/keybindings" = {
      session-add-down = "<Primary><Shift>o";
      session-add-right = "<Primary><Shift>i";
      session-name = "<Primary><Shift>m";
      session-open = "disabled";
      session-switch-to-next-terminal = "disabled";
      session-switch-to-previous-terminal = "disabled";
      session-synchronize-input = "<Primary><Shift>g";
      terminal-find-next = "disabled";
      win-reorder-next-session = "<Primary><Shift>Right";
      win-reorder-previous-session = "<Primary><Shift>Left";
      win-switch-to-next-session = "<Primary>Tab";
      win-switch-to-previous-session = "<Primary><Shift>Tab";
    };

    "com/gexperts/Tilix/profiles" = {
      list = [ "2b7c4080-0ddd-46c5-8f23-563fd3ba789d" ];
    };

    "com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d" = {
      background-color = "#000000000000";
      background-transparency-percent = 0;
      badge-color = "#AC7EA8";
      badge-color-set = true;
      bold-color-set = false;
      bold-is-bright = true;
      cursor-colors-set = false;
      dim-transparency-percent = 28;
      draw-margin = 84;
      font = "BitstreamVeraSansMono Nerd Font Mono 11";
      foreground-color = "#EFEFEF";
      highlight-colors-set = false;
      palette = [ "#000000" "#CC0000" "#4D9A05" "#C3A000" "#3464A3" "#754F7B" "#05979A" "#D3D6CF" "#545652" "#EF2828" "#89E234" "#FBE84F" "#729ECF" "#AC7EA8" "#34E2E2" "#EDEDEB" ];
      scroll-on-output = false;
      scrollback-unlimited = true;
      terminal-bell = "none";
      use-system-font = false;
      use-theme-colors = false;
      visible-name = "Default";
    };

  };
}
