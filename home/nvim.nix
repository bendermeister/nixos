{pkgs, ...}: {
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;

        extraLuaConfig = (builtins.readFile ../source/nvim/init.lua);

        plugins = with pkgs.vimPlugins; [
            rose-pine   
            lualine-nvim
            (nvim-treesitter.withPlugins (p: [
                p.tree-sitter-c
                p.tree-sitter-lua
                p.tree-sitter-yaml
                p.tree-sitter-ledger
                p.tree-sitter-rust
                p.tree-sitter-markdown
                p.tree-sitter-sql
                p.tree-sitter-go
                p.tree-sitter-latex
                p.tree-sitter-toml
                p.tree-sitter-html
                p.tree-sitter-javascript
                p.tree-sitter-nix
            ]))
            plenary # required by telescope
            telescope-nvim
            oil-nvim
            vim-floaterm
            gitsigns-nvim
            nvim-lspconfig
            lazydev-nvim
            nvim-comment

            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            nvim-cmp
        ];
    };
}
