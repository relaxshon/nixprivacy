{ config, lib, pkgs, ... }:

{
 programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      ripgrep
    ];
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
    extraLuaConfig = let
      plugins = with pkgs.vimPlugins; [
        # Include all LazyVim plugins here
        # Example:
        LazyVim
        bufferline-nvim
        cmp-buffer
        cmp-nvim-lsp
        # Add more plugins as needed
      ];
      mkEntryFromDrv = drv: if lib.isDerivation drv then { name = lib.getName drv; path = drv; } else drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in ''
      require("lazy").setup({
        defaults = {
          lazy = true,
        },
        dev = {
          path = "${lazyPath}",
          patterns = { "." },
          fallback = true,
        },
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
          { "williamboman/mason-lspconfig.nvim", enabled = false },
          { "williamboman/mason.nvim", enabled = false },
          { import = "plugins" },
          { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
        },
      })
    '';
 };

 xdg.configFile."nvim/parser".source = let
    parsers = pkgs.symlinkJoin {
      name = "treesitter-parsers";
      paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [ c lua ])).dependencies;
    };
 in "${parsers}/parser";

 xdg.configFile."nvim/lua".source = ./lua;
}

