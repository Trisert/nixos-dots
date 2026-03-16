{ pkgs, inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = true;
        widgets = {
          left = [
            { id = "Launcher"; }
            { id = "Clock"; }
            { id = "ActiveWindow"; }
          ];
          center = [
            { id = "Workspace"; }
          ];
          right = [
            { id = "Tray"; }
            { id = "NotificationHistory"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "ControlCenter"; }
          ];
        };
      };

      colorSchemes = {
        darkMode = true;
        predefinedScheme = "Gruvbox";
      };

      templates.activeTemplates = [
        {
          id = "kitty";
          active = true;
        }
      ];

      general = {
        avatarImage = "/home/nicola/.face";
        radiusRatio = 0.8;
      };

      location = {
        name = "Rome, Italy";
        useFahrenheit = false;
        use12hourFormat = false;
      };
    };
  };
}
