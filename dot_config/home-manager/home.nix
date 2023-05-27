{config, ...}: let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  lib = pkgs.lib;
  nixgl = import sources.nixgl {
    inherit pkgs;
  };
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${lib.getExe nixgl.auto.nixGLDefault} $bin \"\$@\"" > $wrapped_bin
       chmod +x $wrapped_bin
      done
      if [[ -e "$out/share/applications" ]]; then
        rm $out/share
        mkdir $out/share
        ln -s ${pkg}/share/* $out/share/
        rm "$out/share/applications"
        mkdir "$out/share/applications"
        for desktopFile in ${pkg}/share/applications/*; do
           local name="$(basename $desktopFile)"
           substitute "$desktopFile" $out/share/applications/$name --replace ${pkg} $out
        done
      fi
    '';
  defaultShellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    e = "vim";
    c = "cd ..";
    clipin = "xclip -selection clipboard";
    clipout = "xclip -o -selection clipboard";
    cm = "chezmoi";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";
    grep = "grep --color=auto";
    k = "kubectl";
    l = "ls -CF";
    la = "ls -A";
    ll = "ls -alF";
    ls = "ls --color=auto";
    t = "toto.sh";
    todo = "toto.sh";
  };
in {
  imports = [
    ./tilix/default.nix
    ./gnome-terminal/default.nix
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
    # tilix
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    (nerdfonts.override {fonts = ["BitstreamVeraSansMono" "DejaVuSansMono" "Noto" "Ubuntu" "UbuntuMono"];})
    (nixGLWrap pkgs.google-chrome)
    (nixGLWrap pkgs.alacritty)
    age
    alejandra
    asciinema
    authy
    bat
    bazel
    bazelisk
    bitwarden
    bitwarden-cli
    buildah
    caddy
    ccls
    chezmoi
    colordiff
    cosign
    crane
    cue
    cuelsp
    curl
    dagger
    dconf
    dconf2nix
    delta
    delve
    deno
    direnv
    discord
    dive
    fd
    firefox
    fzf
    git
    git-filter-repo
    glow
    gnupg
    go
    golangci-lint
    gopls
    graphviz
    gron
    gum
    helmfile
    hugo
    imagemagick
    inkscape
    jc
    jq
    kapp
    ko
    krew
    kubectl
    kubernetes-helm
    libnotify
    mdsh
    meld
    nginx
    nickel
    nil
    niv
    nixfmt
    nixgl.auto.nixGLDefault
    nmap
    nodePackages.diagnostic-languageserver
    nodePackages.eslint
    nodePackages_latest.bash-language-server
    nodejs
    noto-fonts-emoji
    open-policy-agent
    podman
    powertop
    pre-commit
    rclone
    ripgrep
    rnix-lsp
    rocketchat-desktop
    rustup
    shellcheck
    shfmt
    shutter
    silver-searcher
    skopeo
    socat
    spotify
    sqlite
    stern
    tealdeer
    terraform
    tig
    todo-txt-cli
    tree
    vault
    visidata
    vte
    woodpecker-cli
    xclip
    yarn
    yq
  ];

  home.language = {
    address = "fr_FR.UTF-8";
    base = "en_US.UTF-8";
    collate = "fr_FR.UTF-8";
    ctype = "fr_FR.UTF-8";
    measurement = "fr_FR.UTF-8";
    messages = "en_US.UTF-8";
    monetary = "fr_FR.UTF-8";
    name = "fr_FR.UTF-8";
    numeric = "fr_FR.UTF-8";
    paper = "fr_FR.UTF-8";
    telephone = "fr_FR.UTF-8";
    time = "fr_FR.UTF-8";
  };

  home.sessionVariables = {
    LANGUAGE = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    LC_ALL = "C.UTF-8";
    GTK_THEME = "Mint-Y-Dark-Aqua";
  };

  fonts.fontconfig.enable = true;

  targets.genericLinux.enable = true;

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        # max_line_width = 85;
        indent_style = "space";
        indent_size = 4;
        tab_width = 4;
      };
      "*.{yaml,yml}" = {
        indent_size = 2;
      };
      "*.sh" = {
        indent_size = 2;
      };
      "*.nix" = {
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
      "*.tf" = {
        indent_size = 2;
      };
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    systemDirs = {
      config = ["/etc/xdg"];
      data = ["/usr/share" "/usr/local/share"];
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
      name = "BitstromWera Nerd Font Mono";
      size = 10;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.cinnamon.mint-cursor-themes;
      size = 16;
    };
    iconTheme = {
      package = pkgs.cinnamon.mint-y-icons;
      name = "Mint-Y-Dark-Aqua";
    };
    theme = {
      package = pkgs.cinnamon.mint-themes;
      name = "Mint-Y-Dark-Aqua";
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
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
    enableFishIntegration = false;
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
    package = nixGLWrap pkgs.vscode;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      asciidoctor.asciidoctor-vscode
      asvetliakov.vscode-neovim
      denoland.vscode-deno
      eamodio.gitlens
      hashicorp.terraform
      jnoortheen.nix-ide
      kamadorueda.alejandra
      mads-hartmann.bash-ide-vscode
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.python
      ms-vscode.go
      ms-vsliveshare.vsliveshare
      redhat.vscode-yaml
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

  programs.fish = {
    enable = true;
    shellAliases = defaultShellAliases;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
      #{
      #  name = "fzf-fish";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "PatrickF1";
      #    repo = "fzf.fish";
      #    rev = "175222b9bd79e589da55972b2cd6686b94c6325b";
      #    sha256 = "sha256-aou6UYE6gjLK8J0yXNTFA9yc9Lv8F7ytzBDSmP2K6Sg";
      #  };
      #}
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "38a5b6b6011106092009549e52249c6d6f501fba";
          sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
        };
      }
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = ["erasedups" "ignoredups" "ignorespace"];
    historySize = 20000;
    shellAliases = defaultShellAliases;
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

  services.redshift = {
    enable = true;
    latitude = 48.863049;
    longitude = 2.348856;
    temperature.day = 5500;
    temperature.night = 3000;
  };

  services.systembus-notify.enable = true;
}
