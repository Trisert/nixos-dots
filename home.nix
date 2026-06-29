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

  # Pi AI agent
  programs.pi.coding-agent = {
    enable = true;
    models = ./models.json;
  };

  # Import home modules
  imports = [
    ./home/packages.nix
    ./home/direnv.nix
    ./home/firefox.nix
    ./home/git.nix
    ./home/terminals/default.nix
    ./home/shell/default.nix
    ./home/editor/nixvim.nix
    ./home/wm/hyprland.nix
    # ./home/wm/niri.nix
    ./home/wm/noctalia.nix
    ./home/dev.nix
    ./home/nh.nix
  ];

  # GTK icon theme
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus";
  };

  # Home Manager version
  home.stateVersion = "25.11";
}
