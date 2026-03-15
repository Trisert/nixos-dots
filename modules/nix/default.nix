{
  config,
  pkgs,
  ...
}:

{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;

    # Use all cores for evaluation
    eval-cores = 0;

    # Parallel builds
    max-jobs = "auto";

    # Keep eval cache
    eval-cache = true;

    # Substitutes
    substitute = true;
    builders-use-substitutes = true;
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryMax = "24G";
    OOMPolicy = "kill";
  };

  nix.gc = {
    automatic = true;
    dates = "hourly";
  };

  environment.variables.EDITOR = "neovim";
}
