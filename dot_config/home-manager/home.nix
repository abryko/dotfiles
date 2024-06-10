{
  myInputs,
  pkgs,
  lib,
  config,
  ...
}: let
  system = pkgs.hostPlatform.system;
  nickel = myInputs.nickel.packages.${system}.default;
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
    t = "todo.sh";
    todo = "todo.sh";
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
    # vault
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    (lib.hiPrio nix)
    (mdformat.withPlugins (p: [p.mdit-py-plugins p.mdformat-tables p.mdformat-frontmatter]))
    (nerdfonts.override {fonts = ["BitstreamVeraSansMono" "DejaVuSansMono" "Noto" "Ubuntu" "UbuntuMono"];})
    (nixGLWrap alacritty)
    (nixGLWrap element-desktop)
    (nixGLWrap firefox)
    (nixGLWrap google-chrome)
    (nixGLWrap krita)
    (nixGLWrap neovide)
    (nixGLWrap obsidian)
    (nixGLWrap youtube-music)
    age
    alejandra
    archiver
    asciinema
    bashInteractive
    bat
    bazel
    bazelisk
    bitwarden
    bitwarden-cli
    btop
    buildah
    caddy
    cargo
    ccls
    chezmoi
    clang-tools
    cntr
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
    diffoscope
    discord
    dive
    entr
    erdtree
    fd
    feh
    fuse3
    git
    git-filter-repo
    git-lfs
    gleam
    glow
    gnome.dconf-editor
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
    iotop
    jaq
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
    moreutils
    nginx
    nickel
    nil
    niv
    nix-output-monitor
    nix-tree
    nixd
    nixfmt-rfc-style
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
    npins
    nvd
    open-policy-agent
    page
    podman
    powertop
    pre-commit
    pyright
    rclone
    ripgrep
    rocketchat-desktop
    rust-analyzer
    rustc
    rustfmt
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
    vals
    visidata
    vlc
    vte
    woodpecker-cli
    xclip
    xcwd
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
    _ZL_MAXAGE = "10000";
    # SHELL = lib.getExe config.programs.zsh.package;
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

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod4";
        bars = lib.mkForce [];
        terminal = ''--no-startup-id alacritty --working-directory="`xcwd`" -e zsh'';
        # terminal = ''--no-startup-id kitty --working-directory="`xcwd`" zsh'';
        startup = [
          # {
          #   command = "${lib.getExe pkgs.autotiling}";
          #   notification = false;
          #   always = true;
          # }
          {
            command = "systemctl start --user dummy-graphical.service";
            notification = false;
          }
          {
            command = "feh --scale-down --bg-scale ${./img/wallpaper.jpg}";
            notification = false;
            always = true;
          }
        ];
        gaps = let
          gapPixel = 0;
        in {
          smartGaps = true;
          top = gapPixel;
          bottom = gapPixel;
          horizontal = gapPixel;
          vertical = gapPixel;
          left = gapPixel;
          right = gapPixel;
          inner = gapPixel;
          outer = gapPixel;
        };
        colors.focused = {
          background = "#285577";
          border = "#5acf00";
          childBorder = "#5acf00";
          indicator = "#2e9ef4";
          text = "#ffffff";
        };
        focus.newWindow = "focus";
        window = {
          hideEdgeBorders = "none";
          titlebar = false;
          commands = [
            {
              command = "border normal 3";
              criteria = {class = ".*";};
            }
          ];
        };
        keybindings = let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in
          lib.mkOptionDefault {
            "${modifier}+z" = "focus child";
            "${modifier}+d" = "exec --no-startup-id ${lib.getExe pkgs.rofi} -show drun";
          };
      };
    };
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
    enableBashIntegration = true;
    enableZshIntegration = true;
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
      golang.go
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
    enableZshIntegration = true;
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

  programs.kitty = {
    enable = true;
    package = nixGLWrap pkgs.kitty;
    font = {
      name = "BitstromWera Nerd Font Mono";
      size = 11;
    };
    theme = "Tango Dark";
    keybindings = {
      "kitty_mod+t" = "no_op";
      "kitty_mod+enter" = "no_op";
      "kitty_mod+w" = "no_op";
    };
    settings = {
      shell_integration = "enabled";
      copy_on_select = "yes";
      scrollback_pager = "page";
      enable_audio_bell = "no";
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
  home.stateVersion = "23.11";

  services.picom = {
    enable = true;
    vSync = true;
    fade = true;
  };

  services.copyq = {
    enable = true;
    systemdTarget = "graphical-session.target";
  };

  services.ssh-agent.enable = true;

  services.redshift = {
    enable = true;
    latitude = 48.863049;
    longitude = 2.348856;
    temperature.day = 6000;
    temperature.night = 3500;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.systembus-notify.enable = true;

  systemd.user.services = {
    dummy-graphical = {
      Unit = {
        Description = "dummy service to reach graphical-session.target";
        Requires = ["basic.target"];
        BindsTo = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
        Before = ["graphical-session.target"];
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = "${pkgs.coreutils}/bin/true";
        Restart = "on-failure";
      };
    };
  };
}
