{ config, pkgs, ... }:

let 
  myFontPkg = pkgs.nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "DejaVuSansMono" "Noto" "Ubuntu" "UbuntuMono" ]; };
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "xmaillard";
  home.homeDirectory = "/home/xmaillard";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    age
    authy
    bitwarden
    bitwarden-cli
    chezmoi
    cue
    curl
    direnv
    discord
    fd
    fzf
    gnupg
    go
    golangci-lint
    graphviz
    gron
    inkscape
    jc
    jq
    libnotify
    niv
    nixfmt
    nmap
    myFontPkg
    noto-fonts-emoji
    open-policy-agent
    pre-commit
    ripgrep
    rclone
    rocketchat-desktop
    rustup
    shellcheck
    shfmt
    silver-searcher
    spotify
    tealdeer
    terraform
    todo-txt-cli
    yq
  ];

  fonts.fontconfig.enable = true;

  targets.genericLinux.enable = true;

  xdg = {
    enable = true;
    mime.enable = true;
    systemDirs = {
      config = [ "/etc/xdg" ];
      data = [ "/usr/share" "/usr/local/share" ];
    };
    # Fix symlink rights for snapd
    userDirs = {
      enable = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      publicShare = "$HOME/Public";
      templates = "$HOME/Templates";
      videos = "$HOME/Videos";
    };
  };

  gtk = {
    enable = true;
    font = {
      package = myFontPkg;
      name = "BitstreamVeraSansMono Nerd Font Mono";
      size = 10;
    };
    cursorTheme = {
      name = "Adwaita";
      size = 30;
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita";
    };
  };

  programs.terminator = {
    enable = true;
    config = {
      global_config = {
        scroll_tabbar = true;
        title_transmit_bg_color = "#61996b";
        inactive_color_offset = 0.80;
        title_use_system_font = false;
        title_font = "BitstreamVeraSansMono Nerd Font Mono 9";
      };
      keybindings = {
        split_vert = "<Primary><Shift>i";
        split_horiz = "<Primary><Shift>o";
        toggle_zoom = "<Primary><Shift>x";
        group_all = null;
        group_all_toggle = "<Primary><Shift>h";
        group_tab = null;
        group_tab_toggle = "<Primary><Shift>g";
        new_window = null;
        reset_clear = null;
      };
      profiles.default = {
        use_system_font = false;
        font = "BitstreamVeraSansMono Nerd Font Mono Roman 10";
        scroll_on_output = true;
        scrollback_infinite = true;
        background_color = "#000000";
        foreground_color = "#ffffff";
        palette = "#2e3436:#cc0000:#499105:#c4a000:#3968a3:#75507b:#06989a:#d3d7cf:#555753:#ef2929:#8ae234:#fce94f:#729fcf:#ad7fa8:#34e2e2:#eeeeec";
      };
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    settings = {
      add_newline = true;
      format = "$all";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    tmux.enableShellIntegration = true;
  };

  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
  };

  programs.neovim = {
    enable = true;
    coc.enable = true;
  };

  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.less.enable = true;
  programs.man.enable = true;
  programs.tealdeer.enable = true;
  programs.tmux.enable = true;

  programs.gnome-terminal = {
    enable = true;
    themeVariant = "dark";
    profile = {
      "4dff060d-cd00-450a-888f-309315596f9b" = {
        allowBold = true;
        audibleBell = true;
        backspaceBinding = "ascii-delete";
        boldIsBright = true;
        colors = {
          backgroundColor = "#000000";
          foregroundColor = "#ffffff";
          palette = [
            "#2e3436"
            "#cc0000"
            "#4e9a06"
            "#c4a000"
            "#3465a4"
            "#75507b"
            "#06989a"
            "#d3d7cf"
            "#555753"
            "#ef2929"
            "#8ae234"
            "#fce94f"
            "#729fcf"
            "#ad7fa8"
            "#34e2e2"
            "#eeeeec"
          ];
        };
        cursorBlinkMode = "on";
        cursorShape = "block";
        default = true;
        deleteBinding = "delete-sequence";
        scrollbackLines = 1000000;
        scrollOnOutput = false;
        showScrollbar = true;
        transparencyPercent = null;
        visibleName = "default";
      };
    };
    showMenubar = false;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historySize = 20000;
    shellAliases = {
      c = "cd ..";
      ls = "ls --color=auto";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
