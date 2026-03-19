{
  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.numtide.com"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "devenv.cachix.org-1:w1cLUi8dv3hFqSPwmOyFuP2AKQluN1ZEE4mAQ2qU2ws="
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

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # LLM agents
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      hyprland,
      nixvim,
      determinate,
      llama-cpp,
      firefox-addons,
      llm-agents,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          { nix.settings.trusted-users = [ "nicola" ]; }
          {
            nixpkgs.overlays = [
              (final: prev: {
                llama-cpp-cuda = (
                  llama-cpp.packages.${prev.stdenv.hostPlatform.system}.cuda.overrideAttrs (old: {
                    cmakeFlags = (old.cmakeFlags or [ ]) ++ [
                      "-DCMAKE_CUDA_ARCHITECTURES=60;75"
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
              extraSpecialArgs = { inherit inputs; };
              users.nicola =
                { pkgs, inputs, ... }:
                {
                  imports = [
                    ./home.nix
                    nixvim.homeModules.nixvim
                  ];
                  wayland.windowManager.hyprland = {
                    enable = true;
                    xwayland.enable = true;
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
