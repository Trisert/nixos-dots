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
    connect-timeout = 5;

    # Auto cleanup when disk is low
    min-free = 1073741824; # 1GB
    max-free = 5368709120; # 5GB
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryMax = "20G";
    OOMPolicy = "kill";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  environment.variables.EDITOR = "neovim";
}
