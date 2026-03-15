# NixOS Modular Configuration

A modular, well-organized NixOS configuration optimized for parallel evaluation and maintainability. Built with [Determinate Systems Nix](https://github.com/DeterminateSystems/nix-installer).

## Overview

This configuration uses a modular architecture that separates different aspects of system and user configuration into distinct files. This organization enables:

- **Parallel evaluation**: Nix can evaluate multiple modules simultaneously
- **Maintainability**: Easy to locate and modify specific configurations
- **Reusability**: Modules can be shared across different systems
- **Clarity**: Clear separation of concerns

## Structure

```
.
├── flake.nix              # Main flake entry point
├── configuration.nix     # System configuration entry point
├── hardware-configuration.nix  # Hardware-specific config (not tracked)
├── home.nix              # Home Manager entry point
├── modules/              # System modules
│   ├── boot.nix
│   ├── display/default.nix
│   ├── fonts.nix
│   ├── hardware/nvidia.nix
│   ├── internationalization.nix
│   ├── networking.nix
│   ├── nix/default.nix
│   ├── packages.nix
│   ├── services/default.nix
│   └── users/default.nix
└── home/                 # Home Manager modules
    ├── editor/nixvim.nix
    ├── git.nix
    ├── packages.nix
    ├── shell/default.nix
    ├── terminals/default.nix
    ├── waybar.nix
    └── wm/hyprland.nix
```

## System Modules

- **boot.nix**: Bootloader and kernel configuration
- **display/default.nix**: Display manager (SDDM) and window manager (Hyprland)
- **fonts.nix**: System fonts
- **hardware/nvidia.nix**: NVIDIA GPU configuration and power management
- **internationalization.nix**: Locale, timezone, and keyboard settings
- **networking.nix**: Network manager and hostname
- **nix/default.nix**: Nix settings, garbage collection, and substituters
- **packages.nix**: System-wide packages and unfree settings
- **services/default.nix**: Pipewire, earlyoom, printing, Steam, SSH
- **users/default.nix**: User accounts and groups

## Home Manager Modules

- **editor/nixvim.nix**: Neovim configuration with plugins and LSP
- **git.nix**: Git configuration
- **packages.nix**: User-specific packages
- **shell/default.nix**: Bash, starship, and zoxide configuration
- **terminals/default.nix**: Kitty terminal and tofi launcher
- **waybar.nix**: Wayland status bar configuration
- **wm/hyprland.nix**: Hyprland keybindings and settings

## Features

- **Desktop Environment**: Hyprland (Wayland) + SDDM
- **Theme**: Stylix with Catppuccin-based dark theme
- **Editor**: Nixvim with LSP for Python, TypeScript, Rust, and Nix
- **Shell**: Bash with Starship prompt and Zoxide
- **Terminal**: Kitty with Nerd Fonts
- **Hardware Support**: NVIDIA GPU with TDP management
- **Services**: Pipewire, Steam, EarlyOOM for memory management

## Usage

### Rebuilding the system

To apply changes:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

To test changes without applying:

```bash
sudo nixos-rebuild test --flake .#nixos
```

To update flake inputs:

```bash
nix flake update
```

### Updating Home Manager

Home Manager is automatically applied as part of the NixOS rebuild.

## Flakes

This configuration uses the following flakes:

- **nixpkgs**: NixOS unstable channel
- **home-manager**: User configuration management
- **hyprland**: Dynamic tiling Wayland compositor
- **nixvim**: Neovim configuration with Nix
- **determinate**: Determinate Systems Nix modules
- **llama.cpp**: LLM inference with CUDA support
- **stylix**: System-wide theming

## Hardware Configuration

Hardware-specific configuration is stored in `hardware-configuration.nix` and is **not tracked in git**. After generating new hardware configuration, add it to `.gitignore` and remove it from git tracking:

```bash
git rm --cached hardware-configuration.nix
```

## Customization

### Adding a new system module

1. Create a new file in `modules/` (e.g., `modules/custom.nix`)
2. Import it in `configuration.nix`:
   ```nix
   imports = [
     # ... other modules
     ./modules/custom.nix
   ];
   ```

### Adding a new home module

1. Create a new file in `home/` (e.g., `home/custom.nix`)
2. Import it in `home.nix`:
   ```nix
   imports = [
     # ... other modules
     ./home/custom.nix
   ];
   ```

## Performance

The modular structure enables Nix to evaluate modules in parallel where possible, reducing rebuild times for complex configurations.

## License

This configuration is provided as-is for personal use.

## Author

Created by [Nicola Destro](mailto:nicolade03@gmail.com)
