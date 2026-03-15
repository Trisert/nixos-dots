{
  nixConfig = {
    substituters = [
      "https://cache.nixos.org" # ← add this
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org" # useful given you use hyprland flake
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" # ← add this
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    llama-cpp = {
      url = "github:ggerganov/llama.cpp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      hyprland,
      nixvim,
      determinate,
      llama-cpp,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { _module.args.inputs = inputs; }
          { nix.settings.trusted-users = [ "nicola" ]; }
          {
            nixpkgs.overlays = [
              (final: prev: {
                llama-cpp-cuda = (
                  llama-cpp.packages.${prev.stdenv.hostPlatform.system}.cuda.overrideAttrs (old: {
                    cmakeFlags = (old.cmakeFlags or [ ]) ++ [
                      "-DCMAKE_CUDA_ARCHITECTURES=60;75;80;86"
                    ];
                  })
                );
              })
            ];
          }
          determinate.nixosModules.default
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nicola =
                { pkgs, ... }:
                {
                  imports = [
                    ./home.nix
                    nixvim.homeModules.nixvim
                  ];
                  wayland.windowManager.hyprland = {
                    enable = true;
                    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                    portalPackage =
                      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
                  };
                };
            };
          }
        ];
      };
    };
}
