{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "nicola";
  home.homeDirectory = "/home/nicola";
  home.file.".inputrc".text = ''
    set completion-ignore-case on
  '';

  programs.waybar = {
    enable = true;
    style = ''
      * {
        background-color: @base00;
        color: @base05;
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: 'CaskaydiaMono Nerd Font', monospace;
        font-size: 12px;
      }

      .modules-left { margin-left: 8px; }
      .modules-right { margin-right: 8px; }

      #workspaces button {
        all: initial;
        padding: 0 6px;
        margin: 0 1.5px;
        min-width: 9px;
        color: @base05;
      }

      #workspaces button.active {
        color: @base0D;
      }

      #workspaces button.empty { opacity: 0.5; }

      #cpu, #battery, #pulseaudio, #network, #clock, #memory, #temperature {
        min-width: 12px;
        margin: 0 7.5px;
      }

      #mpris {
        margin: 0 7.5px;
        color: @base0E;
      }

      tooltip {
        padding: 2px;
        background-color: @base01;
        color: @base05;
      }

      #clock { margin-left: 8.75px; }
      #tray { margin-right: 16px; }
      #network { margin-right: 13px; }

      #battery.warning { color: @base0A; }
      #battery.critical { color: @base08; }
    '';

    settings = [
      {
        layer = "top";
        position = "top";
        height = 26;
        spacing = 0;
        modules-left = [
          "hyprland/workspaces"
          "mpris"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            active = "󱓻";
            default = "";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
        };

        mpris = {
          format = " {title}";
          format-paused = " {title}";
          player-icons.default = "▶";
          status-icons.paused = "⏸";
        };

        clock.format = "󰥔 {:%H:%M}";
        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
        };
        pulseaudio = {
          format = "󰕾 {volume}%";
          format-muted = "󰖁";
        };
        cpu.format = "󰘚 {usage}%";
        memory.format = "󰍛 {percentage}%";
        battery = {
          format = "󰁹 {capacity}%";
          format-charging = "󰂄 {capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        tray.spacing = 10;
      }
    ];
  };
  programs.tofi = {
    enable = true;
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
    nixfmt
    swww
    gh
    playerctl
  ];

  programs.kitty = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      n = "nvim";
    };
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
      "waybar"
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
