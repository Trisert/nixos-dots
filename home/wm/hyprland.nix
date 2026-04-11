{
  config,
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    exec-once = [
      "awww-daemon"
      "noctalia-shell"
    ];
    bindm = [
      "SUPER, mouse:272, movewindow"
    ];
    bind = [
      "$mod SHIFT, R, exec, hyprctl reload"
      "$mod, w, killactive,"
      "$mod, SPACE, exec, noctalia-shell ipc call launcher toggle"
      "$mod, L, exec, noctalia-shell ipc call lockScreen lock"
      "$mod, Return, exec, kitty"
      "$mod, b, exec, firefox"
      "$mod, e, exec, thunar"
      ", Print, exec, grimblast copy area"
      "$mod, N, exec, noctalia-shell ipc call controlCenter toggle"
      ", XF86AudioMute, exec, noctalia-shell ipc call volume muteOutput"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
    binde = [
      ", XF86AudioRaiseVolume, exec, noctalia-shell ipc call volume increase"
      ", XF86AudioLowerVolume, exec, noctalia-shell ipc call volume decrease"
    ]
    ++ (builtins.concatLists (
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
    ));
    input = {
      kb_layout = "it";
    };
  };
}
