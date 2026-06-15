{ pkgs, inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      shell = {
        avatar_path = "/home/nicola/.face";
        corner_radius_scale = 0.8;
      };

      bar = {
        main = {
          position = "top";
          capsule = true;
          thickness = 28;
          margin_h = 180;
          margin_v = 10;

          start = [ "launcher" "clock" ];
          center = [ "workspaces" ];
          end = [ "tray" "notifications" "battery" "volume" "control-center" ];
        };
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Gruvbox";
        templates = {
          enable_builtin_templates = true;
          builtin_ids = [ "kitty" ];
        };
      };

      location = {
        address = "Rome, Italy";
        auto_locate = false;
      };
    };
  };
}
