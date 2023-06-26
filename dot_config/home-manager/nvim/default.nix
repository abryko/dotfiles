{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    coc = {
      enable = true;
      settings = {
        "coc.preferences.formatOnType" = true;
        "coc.preferences.formatOnSaveFiletypes" = [
          "cue"
          "go"
          "javascript"
          "nix"
          "sh"
          "typescript"
        ];
        "suggest.noselect" = true;
        "suggest.enablePreselect" = false;
        languageserver = {
          ccls = {
            command = "ccls";
            rootPatterns = [".ccls" "compile_commands.json" ".git/" ".hg/"];
            filetypes = ["c" "cc" "cpp" "c++" "objc" "objcpp"];
            initializationOptions = {
              cache.directory = "/tmp/ccls";
            };
          };
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
          vim = {
            command = "vim-language-server";
            args = ["--stdio"];
            initializationOptions = {
              isNeovim = true;
              iskeyword = "@,48-57,_,192-255,-#"; # vim iskeyword option
              vimruntime = ""; # $VIMRUNTIME option
              runtimepath = ""; # vim runtime path separate by `,`
              diagnostic = {
                enable = true;
              };
              indexes = {
                runtimepath = true; # if index runtimepath's vim files this will effect the suggest
                gap = 100; # index time gap between next file
                count = 3; # count of files index at the same time
                projectRootPatterns = ["strange-root-pattern" ".git" "autoload" "plugin"]; # Names of files used as the mark of project root. If empty, the default value [".git", "autoload", "plugin"] will be used
              };
              suggest = {
                fromVimruntime = true; # completionItems from vimruntime's vim files
                fromRuntimepath = false; # completionItems from runtimepath's vim files, if this is true that fromVimruntime is true
              };
            };
            filetypes = ["vim"];
          };
          lua = {
            command = "lua-language-server";
            filetypes = ["lua"];
            args = ["--stdio"];
            rootPatterns = [".luarc.json" ".luarc.jsonc" ".luacheckrc" ".stylua.toml" "stylua.toml" "selene.toml" "selene.yml" ".git"];
            settings = {
              lua.telemetry.enable = false;
              lua.diagnostics.globals = ["vim"];
            };
          };
          diagnostic-ls = {
            command = "diagnostic-languageserver";
            args = ["--stdio"];
            filetypes = ["sh"];
            initializationOptions = {
              formatFiletypes = {
                sh = "shfmt";
              };
              formatters = {
                shfmt = {
                  command = "shfmt";
                  args = ["-i" "2" "-bn" "-ci" "-sr"];
                };
              };
            };
          };
        };
      };
    };
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [p.bash p.c p.cpp p.cue p.go p.lua p.make p.markdown p.markdown_inline p.nix p.regex p.typescript p.vim]))
      catppuccin-nvim
      cmp-cmdline
      cmp-fuzzy-buffer
      cmp-fuzzy-path
      coc-fzf
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
      nvim-notify
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects
      telescope-coc-nvim
      telescope-fzf-native-nvim
      telescope-nvim
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
