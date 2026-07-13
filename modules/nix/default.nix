{
  config,
  pkgs,
  ...
}:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    sandbox = true;

    # Use all cores for evaluation
    eval-cores = 0;

    # Parallel builds
    max-jobs = "auto";

    # Use all cores per derivation (critical for C++/CUDA builds)
    cores = 0;

    # Keep eval cache
    eval-cache = true;

    # Substituters
    substituters = [
      "https://cache.nixos.org"
      "https://noctalia.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
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
