{
  myInputs,
  pkgs,
  config,
  ...
}: let
  system = pkgs.hostPlatform.system;
  lib = pkgs.lib;
  nickel = myInputs.nickel.packages.${system}.default;
  open-policy-agent = myInputs.nixpkgs-opa.legacyPackages.${system}.open-policy-agent;
  nixgl = myInputs.nixGL.packages.${system};
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "#!${pkgs.runtimeShell}" > $wrapped_bin
       echo "exec ${nixgl.nixGLDefault}/bin/nixGL $bin \"\$@\"" >> $wrapped_bin
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
    ./zsh
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "xmaillard";
  home.homeDirectory = "/home/xmaillard";
  home.sessionPath = [
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.krew/bin"
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/go/bin"
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    (nerdfonts.override {fonts = ["BitstreamVeraSansMono" "DejaVuSansMono" "Noto" "Ubuntu" "UbuntuMono"];})
    (nixGLWrap alacritty)
    (nixGLWrap element-desktop)
    (nixGLWrap firefox)
    (nixGLWrap google-chrome)
    (nixGLWrap krita)
    (nixGLWrap neovide)
    (nixGLWrap obsidian)
    (nixGLWrap youtube-music)
    (python311Packages.mdformat.withPlugins [python311Packages.mdit-py-plugins python311Packages.mdformat-tables python311Packages.mdformat-frontmatter])
    age
    alejandra
    asciinema
    authy
    bashInteractive
    bat
    bazel
    bazelisk
    bitwarden
    bitwarden-cli
    buildah
    caddy
    cargo
    ccls
    chezmoi
    colordiff
    cosign
    crane
    cue
    cuelsp
    curl
    dconf
    dconf2nix
    delta
    delve
    deno
    discord
    dive
    fd
    fuse3
    git
    git-filter-repo
    git-lfs
    glow
    gnupg
    go
    golangci-lint
    golangci-lint-langserver
    gopls
    graphviz
    gron
    gum
    haskell-language-server
    helmfile
    hugo
    hyperfine
    imagemagick
    inkscape
    jc
    jq
    k9s
    kapp
    ko
    krew
    kubectl
    kubernetes-helm
    libnotify
    litefs
    ltex-ls
    lua-language-server
    marksman
    mdsh
    meld
    minio
    nginx
    nickel
    nil
    niv
    nixd
    nixfmt
    nixgl.nixGLDefault
    nmap
    nodePackages.diagnostic-languageserver
    nodePackages.eslint
    nodePackages.markdownlint-cli
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages_latest.bash-language-server
    nodejs
    noto-fonts-emoji
    nvd
    open-policy-agent
    page
    podman
    powertop
    pre-commit
    pyright
    rclone
    ripgrep
    rnix-lsp
    rocketchat-desktop
    rust-analyzer
    rustc
    shellcheck
    shfmt
    shutter
    silver-searcher
    skopeo
    socat
    sops
    spotify
    sqlite
    stern
    tealdeer
    tig
    todo-txt-cli
    topiary
    tree
    tree-sitter
    vault
    visidata
    vte
    woodpecker-cli
    xclip
    yarn
    yq
    zig
    zsh
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
    EDITOR = "vim";
    SUDO_EDITOR = "vim";
    VISUAL = "vim";
    GOPATH = "${config.home.homeDirectory}/go";
    GTK_THEME = "Mint-Y-Dark-Aqua";
    LANG = "en_US.UTF-8";
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "C.UTF-8";
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
      "*.{json,yaml,yml}" = {
        indent_size = 2;
      };
      "*.sh" = {
        indent_size = 2;
      };
      "*.lua" = {
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
      format = lib.concatStrings [
        "$all"
      ];
    };
  };

  programs.fzf = {
    enable = true;
    # atuin is used instead
    enableBashIntegration = false;
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
    package = (nixGLWrap pkgs.vscode).overrideAttrs (
      old: {
        inherit (pkgs.vscode) pname version;
      }
    );
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      # ms-python.python
      asciidoctor.asciidoctor-vscode
      asvetliakov.vscode-neovim
      denoland.vscode-deno
      eamodio.gitlens
      editorconfig.editorconfig
      hashicorp.terraform
      jnoortheen.nix-ide
      kamadorueda.alejandra
      mads-hartmann.bash-ide-vscode
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-vscode.go
      ms-vsliveshare.vsliveshare
      redhat.vscode-yaml
    ];
  };

  programs.htop = {
    enable = true;
  };
  programs.jq = {
    enable = true;
  };
  programs.less.enable = true;
  programs.man.enable = true;
  programs.tealdeer.enable = true;
  programs.tmux = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        warn_timeout = "45s";
        disable_stdin = true;
        load_dotenv = true;
      };
    };
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

  programs.zellij = {
    enable = true;
  };

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

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Depends on nix-index-database module
  programs.nix-index-database.comma.enable = true;

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
  home.stateVersion = "23.05";

  services.copyq = {
    enable = true;
    systemdTarget = "graphical-session.target";
  };

  services.redshift = {
    enable = true;
    latitude = 48.863049;
    longitude = 2.348856;
    temperature.day = 6000;
    temperature.night = 3500;
  };

  services.gpg-agent.enable = true;
  services.systembus-notify.enable = true;
}
