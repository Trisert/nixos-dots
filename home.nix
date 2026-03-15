# Modular Home Configuration
# This is the main entry point for user-specific configuration
# All home configuration is organized into separate modules for maintainability

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  home.username = "nicola";
  home.homeDirectory = "/home/nicola";

  # Custom .inputrc configuration
  home.file.".inputrc".text = ''
    set completion-ignore-case on
  '';

  # Import home modules
  imports = [
    ./home/packages.nix
    ./home/git.nix
    ./home/terminals/default.nix
    ./home/shell/default.nix
    ./home/editor/nixvim.nix
    ./home/wm/hyprland.nix
    ./home/waybar.nix
  ];

  # Enable Hyprland window manager
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable nixvim
  programs.nixvim.enable = true;

  # Home Manager version
  home.stateVersion = "25.11";
}
