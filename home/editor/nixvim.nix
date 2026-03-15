{
  config,
  pkgs,
  ...
}:

{
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    opts = {
      number = true;
    };

    plugins = {
      neo-tree.enable = true;
      telescope.enable = true;
      treesitter.enable = true;

      web-devicons.enable = true;

      lsp = {
        enable = true;
        servers = {
          pyright.enable = true;
          ts_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          nixd.enable = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };

      conform-nvim = {
        enable = true;
        settings.formatters_by_ft = {
          python = [ "black" ];
          nix = [ "nixfmt" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
        };
      };

      nvim-autopairs.enable = true;
      gitsigns.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
    };
  };
}
