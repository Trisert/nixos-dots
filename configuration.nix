# Modular NixOS Configuration
# This is the main entry point for system-wide configuration
# All configuration is organized into separate modules for maintainability

{ config
, pkgs
, inputs
, ...
}:

{
  imports = [
    # Include the results of the hardware scan (not tracked in git)
    ./hardware-configuration.nix

    # System modules
    ./modules/nix/default.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/internationalization.nix
    ./modules/fonts.nix
    ./modules/hardware/default.nix
    ./modules/hardware/nvidia.nix
    ./modules/display/default.nix
    ./modules/services/default.nix
    ./modules/users/default.nix
    ./modules/packages.nix
  ];

  # GTK theme
  environment.variables.GTK_THEME = "Adwaita:dark";

  # Enable Wayland-native mode for Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "25.11";
}
