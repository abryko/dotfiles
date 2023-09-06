{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    autocd = false;
    shellAliases = config.programs.bash.shellAliases;
    localVariables = {
      CASE_SENSITIVE = "true";
      COMPLETION_WAITING_DOTS = true;
      DIRENV_WARN_TIMEOUT = "40s";
      SHELL = "zsh";
      ZLE_RPROMPT_INDENT = "0";
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = 200;
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=4";
      ZSH_AUTOSUGGEST_MANUAL_REBIND = 1;
      ZSH_AUTOSUGGEST_STRATEGY = "history";
      ZSH_DISABLE_COMPFIX = true;
    };
    enableAutosuggestions = false;
    enableCompletion = true;
    syntaxHighlighting.enable = false;
    enableVteIntegration = true;
    envExtra = builtins.readFile ./zshenv;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 60000;
      share = true;
      size = 60000;
    };
    initExtra = builtins.readFile ./zshrc;
    plugins = let
      sources = import ./nix/sources.nix {};
    in [
      {
        name = "completion";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/lib/completion.zsh";
      }
      {
        name = "key-bindings";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/lib/key-bindings.zsh";
      }
      {
        name = "spectrum";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/lib/spectrum.zsh";
      }
      {
        name = "history";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/lib/history.zsh";
      }
      {
        name = "directories";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/lib/directories.zsh";
      }
      {
        name = "docker-compose";
        src = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/docker-compose";
      }
      {
        name = "terraform";
        src = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/terraform";
      }
      {
        name = "vault";
        src = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/vault";
      }
      {
        name = "pip";
        src = "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/pip";
      }
      {
        name = "completion";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/lib/completion.zsh";
      }
      {
        name = "fzf";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/fzf/fzf.plugin.zsh";
      }
      {
        name = "zsh-defer";
        src = pkgs.fetchFromGitHub {
          inherit (sources.zsh-defer) owner repo rev sha256;
        };
        file = "zsh-defer.plugin.zsh";
      }
      {
        name = "zsh-completions";
        src = "${pkgs.zsh-completions}/share/zsh/site-functions";
      }
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          inherit (sources.fasd) owner repo rev sha256;
        };
        file = "fasd.plugin.zsh";
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          inherit (sources.z) owner repo rev sha256;
        };
        file = "z.sh";
      }
      {
        name = "fz";
        src = pkgs.fetchFromGitHub {
          inherit (sources.fz) owner repo rev sha256;
        };
        file = "fz.sh";
      }
      {
        name = "cp";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/cp/cp.plugin.zsh";
      }
      {
        name = "colored-man-pages";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/colored-man-pages/colored-man-pages.plugin.zsh";
      }
      {
        name = "systemd";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/systemd/systemd.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "atuin";
        src = pkgs.fetchFromGitHub {
          inherit (sources.atuin) owner repo rev sha256;
        };
        file = "atuin.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "sudo";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/sudo/sudo.plugin.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          inherit (sources.zsh-autosuggestions) owner repo rev sha256;
        };
        file = "zsh-autosuggestions.plugin.zsh";
      }
      {
        name = "zsh-fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
    ];
  };
}
