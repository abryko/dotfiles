{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # coc-fzf
      # telescope-coc-nvim
      (nvim-treesitter.withPlugins (p: [p.bash p.c p.cpp p.cue p.dockerfile p.go p.gomod p.gosum p.hcl p.ini p.json p.lua p.make p.markdown p.markdown_inline p.nickel p.nix p.python p.regex p.rego p.rust p.typescript p.vim p.yaml]))
      catppuccin-nvim
      cmp-cmdline
      cmp-cmdline-history
      cmp-fuzzy-buffer
      cmp-fuzzy-path
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      cmp-treesitter
      cmp_luasnip
      comment-nvim
      completion-treesitter
      editorconfig-nvim
      fuzzy-nvim
      gruvbox-nvim
      lualine-nvim
      luasnip
      noice-nvim
      nui-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-notify
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      tokyonight-nvim
      vim-cue
      vim-fugitive
      vim-indentwise
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
