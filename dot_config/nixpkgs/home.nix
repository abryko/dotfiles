{ config, pkgs, ... }:

{

  imports = [
    ./tilix/default.nix
    ./nvim/default.nix
  ];
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
    dconf
    dconf2nix
    direnv
    discord
    fd
    fzf
    git
    git-filter-repo
    gnupg
    go
    golangci-lint
    graphviz
    gron
    inkscape
    jc
    jq
    libnotify
    (nerdfonts.override {
      fonts = [ "BitstreamVeraSansMono" "DejaVuSansMono" "Noto" "Ubuntu" "UbuntuMono" ];
    })
    niv
    nixfmt
    nmap
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
    tilix
    tig
    todo-txt-cli
    yq
  ];

  fonts.fontconfig.enable = true;

  targets.genericLinux.enable = true;

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

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        max_line_width = 85;
        indent_style = "space";
        indent_size = 4;
        tab_width = 4;
      };
      "*.nix" = {
        indent_style = "space";
        indent_size = 2;
      };
      "*.cue" = {
        indent_style = "tab";
        indent_size = 4;
        tab_width = 4;
      };
      "*.go" = {
        indent_style = "tab";
        indent_size = 4;
        tab_width = 4;
      };
   };
  };

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
      name = "BitstreamVeraSansMono Nerd Font Mono";
      size = 10;
    };
    cursorTheme = {
      name = "Adwaita";
      size = 16;
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

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      asciidoctor.asciidoctor-vscode
      bbenoist.nix
      hashicorp.terraform
      ms-python.python
      ms-vscode.go
      ms-vsliveshare.vsliveshare
      vscodevim.vim
    ];
  };

  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.less.enable = true;
  programs.man.enable = true;
  programs.tealdeer.enable = true;
  programs.tmux.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
    nix-direnv.enable = true;
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
  };

  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = false;
  };

  programs.zellij.enable = true;

  #programs.zsh = {
  #  enable = true;
  #  enableAutosuggestions = true;
  #  enableCompletion = true;
  #  enableSyntaxHighlighting = true;
  #  enableVteIntegration = true;
  #  defaultKeymap = "vicmd";
  #  envExtra = builtins.readFile ./zsh/zshenv;
  #  history = {
  #    expireDuplicatesFirst = true;
  #    extended = true;
  #    ignoreDups = true;
  #    ignoreSpace = true;
  #    save = 60000;
  #    share = true;
  #    size = 60000;
  #  };
  #  initExtra = builtins.readFile ./zsh/zshrc;
  #};

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
