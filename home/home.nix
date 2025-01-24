{pkgs, ...}: {
    home.username = "ben";
    home.homeDirectory = "/home/ben";
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;

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
            telescope-nvim # do we need to install plenary separetly?
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
