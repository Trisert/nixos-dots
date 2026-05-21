{
  config,
  pkgs,
  ...
}:

let
  noctalia = "noctalia-shell ipc call";
in
{
  programs.niri = {
    enable = true;

    settings = {
      prefer-no-csd = true;

      hotkey-overlay.skip-at-startup = true;

      input.keyboard.xkb = {
        layout = "it";
      };

      spawn-at-startup = [
        { argv = [ "awww-daemon" ]; }
        { argv = [ "noctalia-shell" ]; }
      ];

      binds = {
        "Super+Return".action.spawn = [ "kitty" ];
        "Super+Space".action.spawn = [ "sh" "-c" "${noctalia} launcher toggle" ];
        "Super+B".action.spawn = [ "firefox" ];
        "Super+E".action.spawn = [ "thunar" ];
        "Super+W".action.close-window = {};
        "Super+L".action.spawn = [ "sh" "-c" "${noctalia} lockScreen lock" ];
        "Super+N".action.spawn = [ "sh" "-c" "${noctalia} controlCenter toggle" ];
        "Super+Shift+R".action.show-hotkey-overlay = {};

        "Print".action.screenshot = {};

        "XF86AudioMute".action.spawn = [ "sh" "-c" "${noctalia} volume muteOutput" ];
        "XF86AudioMicMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
        "XF86AudioRaiseVolume".action.spawn = [ "sh" "-c" "${noctalia} volume increase" ];
        "XF86AudioLowerVolume".action.spawn = [ "sh" "-c" "${noctalia} volume decrease" ];

        "Super+1".action.focus-workspace = 1;
        "Super+2".action.focus-workspace = 2;
        "Super+3".action.focus-workspace = 3;
        "Super+4".action.focus-workspace = 4;
        "Super+5".action.focus-workspace = 5;
        "Super+6".action.focus-workspace = 6;
        "Super+7".action.focus-workspace = 7;
        "Super+8".action.focus-workspace = 8;
        "Super+9".action.focus-workspace = 9;

        "Super+Shift+1".action.move-column-to-workspace = 1;
        "Super+Shift+2".action.move-column-to-workspace = 2;
        "Super+Shift+3".action.move-column-to-workspace = 3;
        "Super+Shift+4".action.move-column-to-workspace = 4;
        "Super+Shift+5".action.move-column-to-workspace = 5;
        "Super+Shift+6".action.move-column-to-workspace = 6;
        "Super+Shift+7".action.move-column-to-workspace = 7;
        "Super+Shift+8".action.move-column-to-workspace = 8;
        "Super+Shift+9".action.move-column-to-workspace = 9;
      };

      layout = {
        gaps = 16;
        focus-ring = {
          enable = true;
          width = 3;
        };
        border = {
          enable = true;
          width = 2;
        };
      };
    };
  };
}
