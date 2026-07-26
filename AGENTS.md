# NixOS Dots — Agent Guide

## Host & User
- Hostname: `nixos`, user: `nicola`, system: `x86_64-linux`
- Flake output: `.#nixosConfigurations.nixos` (system), `.#homeConfigurations.nicola` (home)

## Key Commands
| Action | Command |
|--------|---------|
| Rebuild system | `sudo nixos-rebuild switch --flake .#nixos` |
| Build home only | `nix build .#homeConfigurations.nicola.activationPackage` |
| Format check | `find . -name '*.nix' -exec nixfmt --check {} +` |
| Lint | `statix check` |
| Flake validate | `nix flake show` |

## Package Locations
- **System-wide** → `modules/packages.nix` (uses `environment.systemPackages`)
- **User-level** → `home/packages.nix` (uses `home.packages`)
- **Dev tools** → `home/dev.nix` (adds to `home.packages`)

## Structure
- `configuration.nix` / `home.nix` — entry points that import modules
- `modules/` — system-level (boot, display, hardware, nix, services, users, packages)
- `home/` — user-level (editor, wm, shell, terminals, git, firefox, direnv, dev, packages, nh)

## Important Details
- `nixpkgs.config.allowUnfree = true` set in `modules/packages.nix`
- CI runs `nixfmt --check` + `statix check` + `nix flake show` + home build
- NVIDIA CUDA architectures: 60 (Pascal), 75 (Turing) — relevant for any CUDA overlay
- Wayland-only (no X11), Hyprland compositor
- `~/.inputrc` managed via `home.file."...inputrc"` in `home.nix`
- nix-daemon memory limit: 20GB
- Substituters in flake.nix (cachix, numtide, etc.) — add new ones there if adding packages from custom inputs
