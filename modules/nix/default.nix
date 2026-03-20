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
