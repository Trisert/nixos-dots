{
  config,
  pkgs,
  ...
}:

{
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
}
