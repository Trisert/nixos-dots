{
  config,
  pkgs,
  ...
}:

{
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
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
    binde = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
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
