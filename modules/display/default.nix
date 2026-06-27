{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.xserver.enable = true;
  services.xserver.layout = "it";

  console.keyMap = "it2";

  services.displayManager.gdm.enable = true;

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  environment.etc."icons/default/index.theme".text = ''
    [Icon Theme]
    Inherits=Adwaita
  '';

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

}
