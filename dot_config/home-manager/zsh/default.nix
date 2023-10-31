{
  lib,
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
      SHELL = "zsh";
      ZLE_RPROMPT_INDENT = "0";
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE = 200;
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=4";
      ZSH_AUTOSUGGEST_MANUAL_REBIND = 1;
      ZSH_AUTOSUGGEST_STRATEGY = "history";
      ZSH_DISABLE_COMPFIX = true;
      FZ_HISTORY_CD_CMD = "_zlua";
      ZLUA_EXEC = lib.getExe' pkgs.lua "lua";
      _FASD_INIT_OPTS = "zsh-hook zsh-wcomp zsh-wcomp-install";
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
        name = "fzf";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/fzf/fzf.plugin.zsh";
      }
      {
        name = "zsh-defer";
        src = sources.zsh-defer;
        file = "zsh-defer.plugin.zsh";
      }
      {
        name = "zsh-completions";
        src = "${pkgs.zsh-completions}/share/zsh/site-functions";
      }
      {
        name = "fasd";
        src = sources.fasd;
        file = "fasd.plugin.zsh";
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
        src = sources.atuin;
        file = "atuin.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "z-lua";
        src = sources.z-lua;
        file = "z.lua.plugin.zsh";
      }
      {
        name = "fz";
        src = sources.fz;
        file = "fz.sh";
      }
      {
        name = "sudo";
        src = pkgs.oh-my-zsh;
        file = "share/oh-my-zsh/plugins/sudo/sudo.plugin.zsh";
      }
      {
        name = "zsh-autosuggestions";
        src = sources.zsh-autosuggestions;
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
