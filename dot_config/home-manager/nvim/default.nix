{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
      settings = {
        "coc.preferences.formatOnType" = true;
        "coc.preferences.formatOnSaveFiletypes" = ["cue" "go" "nix" "sh"];
        "suggest.noselect" = true;
        "suggest.enablePreselect" = false;
        languageserver = {
          go = {
            command = "gopls";
            rootPatterns = ["go.mod"];
            "trace.server" = "verbose";
            filetypes = ["go"];
          };
          cue = {
            command = "cuelsp";
            args = [];
            rootPatterns = ["cue.mod/" ".git/"];
            filetypes = ["cue"];
          };
          nix = {
            command = "nil";
            rootPatterns = ["flake.nix" "shell.nix" ".git/"];
            filetypes = ["nix"];
            settings = {
              nil.formatting.command = ["alejandra"];
            };
          };
          sh = {
            command = "bash-language-server";
            args = ["start"];
            filetypes = ["sh"];
          };
          deno = {
            command = "deno";
            args = ["lsp"];
            filetypes = ["typescript" "javascript"];
            rootPatterns = ["deno.json" "deno.jsonc" ".git/"];
            initializationOptions = {
              enable = true;
              lint = true;
              unstable = true;
            };
          };
        };
      };
    };
    plugins = with pkgs.vimPlugins; [
      coc-fzf
      comment-nvim
      completion-treesitter
      editorconfig-nvim
      lualine-nvim
      nvim-treesitter
      telescope-coc-nvim
      telescope-nvim
      vim-cue
      vim-nix
      vim-surround
      vim-terraform
    ];
    extraConfig = builtins.readFile ./vimrc;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
