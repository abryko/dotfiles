{ config, pkgs, ... }:

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
    bitwarden-cli
    chezmoi
    cue
    curl
    direnv
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
    (nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "DejaVuSansMono" "Noto" "Ubuntu" "UbuntuMono" ]; })
    noto-fonts-emoji
    open-policy-agent
    pre-commit
    ripgrep
    rclone
    rustup
    shellcheck
    shfmt
    silver-searcher
    tealdeer
    terraform
    todo-txt-cli
    yq
  ];

  fonts.fontconfig.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    settings = {};
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

  programs.alacritty = {
    enable = true;
  };

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
