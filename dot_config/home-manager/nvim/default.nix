{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    plugins = let
      ltex_extra-nvim_patched = pkgs.vimPlugins.ltex_extra-nvim.overrideAttrs (_: {
        patches = [
          (pkgs.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/barreiroleo/ltex_extra.nvim/pull/42.patch";
            hash = "sha256-/yPu6p8ofIQrtg8gG8qBEoV7/AdyJtBE1kPnjXM7oo0=";
          })
        ];
      });
    in
      with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (p: [p.bash p.c p.cpp p.cue p.dockerfile p.go p.gomod p.gosum p.hcl p.ini p.json p.lua p.make p.markdown p.markdown_inline p.nickel p.nix p.python p.regex p.rego p.rust p.typescript p.vim p.yaml]))
        catppuccin-nvim
        cmp-cmdline
        cmp-cmdline-history
        cmp-fuzzy-buffer
        cmp-nvim-lsp
        cmp-nvim-lsp-document-symbol
        cmp-nvim-lua
        cmp-path
        cmp-treesitter
        cmp_luasnip
        comment-nvim
        editorconfig-nvim
        fuzzy-nvim
        gruvbox-nvim
        ltex_extra-nvim_patched
        lualine-nvim
        luasnip
        noice-nvim
        nui-nvim
        nvim-cmp
        nvim-dap
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
        vim-nickel
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
