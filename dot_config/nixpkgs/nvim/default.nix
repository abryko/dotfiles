{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
      settings = {
        "suggest.noselect" = false;
        "suggest.enablePreview" = true;
        "suggest.enablePreselect" = false;
        "suggest.disableKind" = true;
       languageserver = {
          go = {
            command =  "gopls";
            rootPattern= [ "go.mod" ];
            "trace.server" = "verbose";
            filetypes =  [ "go" ];
          };
        };
      };
    };
    plugins = with pkgs.vimPlugins; [
      coc-fzf
      comment-nvim
      completion-treesitter
      editorconfig-nvim
      fzf-lua
      lualine-nvim
      nvim-treesitter
      vim-cue
      vim-nix
      vim-terraform-completion
      vim-surround
    ];
    extraConfig = builtins.readFile ./vimrc;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
