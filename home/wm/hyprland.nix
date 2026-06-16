{
  config,
  pkgs,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    settings = {
    "$mod" = "SUPER";
    exec-once = [
      "awww-daemon"
    ];
    bindm = [
      "SUPER, mouse:272, movewindow"
    ];
    bind = [
      "$mod SHIFT, R, exec, hyprctl reload"
      "$mod, w, killactive,"
      "$mod, SPACE, exec, noctalia msg panel-toggle launcher"
      "$mod, L, exec, noctalia msg session lock"
      "$mod, Return, exec, kitty"
      "$mod, b, exec, firefox"
      "$mod, e, exec, thunar"
      ", Print, exec, grimblast copy area"
      "$mod, N, exec, noctalia msg panel-toggle control-center"
      ", XF86AudioMute, exec, noctalia msg volume-mute"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
    binde = [
      ", XF86AudioRaiseVolume, exec, noctalia msg volume-up"
      ", XF86AudioLowerVolume, exec, noctalia msg volume-down"
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
  };
}
