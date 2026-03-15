{
  config,
  pkgs,
  ...
}:

{
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    # Set leader key to space
    globals.mapleader = " ";
    globals.maplocalleader = " ";

    opts = {
      number = true;
      cursorline = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      wrap = false;
      scrolloff = 8;
      sidescrolloff = 8;
      updatetime = 300;
      signcolumn = "yes";
    };

    plugins = {
      neo-tree.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          indent.disable = ["python"];
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          cpp
          lua
          python
          rust
          nix
          javascript
          typescript
          json
          yaml
          markdown
          markdown-inline
        ];
      };

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
        keymaps.lspKeymaps = {
          silent = true;
          diagnostic = {
            "<leader>ld" = "open_float";
            "[d" = "goto_next";
            "]d" = "goto_prev";
          };
          buf = {
            "K" = "hover";
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "go" = "type_definition";
            "gr" = "references";
            "gs" = "signature_help";
            "<leader>lr" = "rename";
            "<leader>la" = "code_action";
            "<leader>lf" = "format";
          };
        };
      };

      lsp-format = {
        enable = true;
        lspServersToEnable = ["pyright" "ts_ls" "rust_analyzer" "nixd"];
      };

      # Inlay hints (inline type information)
      lsp-lines.enable = true;

      # LSP signature help
      lsp-signature = {
        enable = true;
        settings = {
          bind = true;
          floating_window = true;
          hint_enable = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
          };
          snippet.expand = "luasnip";
        };
      };

      luasnip.enable = true;

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
      lualine = {
        enable = true;
        settings = {
          globalstatus = true;
        };
      };
      bufferline.enable = true;

      # which-key - shows available keybindings
      which-key.enable = true;

      # Session management
      persistence = {
        enable = true;
        settings = {
          dir = "~/.config/nvim/sessions";
          options = ["buffers" "curdir" "tabpages" "winsize"];
        };
      };

      # Better indentation guides
      indent-blankline = {
        enable = true;
        settings = {
          indent.enable = true;
        };
      };

      # Auto-pair enhancements
      nvim-autopairs.settings.check_ts = true;

      # Git integration enhancements
      gitsigns.settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          delay = 500;
        };
      };

      # Notify system
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000";
        };
      };

      # UI improvements
      noice = {
        enable = true;
        settings = {
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
          };
        };
      };
    };

    # Autocommands
    autocmd = [
      {
        event = "BufWritePre";
        pattern = ["*"];
        callback = {
          __raw = "function() vim.lsp.buf.format() end";
        };
      }
      {
        event = "TextYankPost";
        pattern = ["*"];
        callback = {
          __raw = "function() vim.highlight.on_yank({higroup = 'Visual', timeout = 200}) end";
        };
      }
      {
        event = "FileType";
        pattern = ["nix"];
        callback = {
          __raw = "function() vim.opt_local.shiftwidth = 2 end";
        };
      }
      {
        event = "FileType";
        pattern = ["python"];
        callback = {
          __raw = "function() vim.opt_local.shiftwidth = 4 end";
        };
      }
      {
        event = "FileType";
        pattern = ["javascript" "typescript" "javascriptreact" "typescriptreact"];
        callback = {
          __raw = "function() vim.opt_local.shiftwidth = 2 end";
        };
      }
      {
        event = "BufRead";
        pattern = ["*"];
        callback = {
          __raw = "function() vim.cmd('silent! normal! zv') end";
        };
      }
    ];

    # Custom Lua configuration
    extraConfigLua = ''
      -- Enable spell checking for certain file types
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "markdown", "text" },
        callback = function()
          vim.opt.spell = true
        end,
      })

      -- Disable diagnostics in virtual text for cleaner look
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- Show line diagnostics automatically on hover
      vim.o.updatetime = 250
      vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
    '';
  };
}
