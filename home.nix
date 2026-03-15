{ config, pkgs, ... }:

{
  home.username = "nicola";
  home.homeDirectory = "/home/nicola";
  home.file.".inputrc".text = ''
    set completion-ignore-case on
  '';

  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 5;
      font = "monospace";
      background-color = "#000A";
    };
  };

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      neo-tree.enable = true;
      telescope.enable = true;
      treesitter.enable = true;

      # Fix: explicit web-devicons instead of auto
      web-devicons.enable = true;

      lsp = {
        enable = true;
        servers = {
          pyright.enable = true;
          ts_ls.enable = true; # Fix: ts-ls → ts_ls
          rust_analyzer = {
            # Fix: rust-analyzer → rust_analyzer
            enable = true;
            installCargo = true; # Fix: let nixvim manage cargo
            installRustc = true; # Fix: let nixvim manage rustc
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

  home.packages = with pkgs; [
    kitty
    nixfmt
    swww
    gh
  ];

  programs.bash = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.git = {
    enable = true;
    settings.user.name = "Nicola Destro";
    settings.user.email = "nicolade03@gmail.com";
    settings = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    exec-once = [
      "swww-daemon"
      "swww img /home/nicola/Pictures/van_allen.jpeg"
    ];
    bindm = [
      "SUPER, mouse:272, movewindow"
    ];
    bind = [
      "$mod, w, killactive,"
      "$mod, SPACE, exec, tofi-run"
      "$mod, Return, exec, kitty"
      "$mod, b, exec, firefox"
      ", Print, exec, grimblast copy area"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );
    input = {
      kb_layout = "it";
    };
  };

  home.stateVersion = "25.11";
}
