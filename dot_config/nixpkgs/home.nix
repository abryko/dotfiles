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
    gron
    jc
    jq
    libnotify
    nixfmt
    nmap
    (nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "Ubuntu" "UbuntuMono" ]; })
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
