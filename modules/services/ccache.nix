{
  config,
  pkgs,
  ...
}:

{
  programs.ccache = {
    enable = true;
    packageNames = [
      "llama-cpp-cuda"
    ];
  };

  nix.settings.extra-sandbox-paths = [
    config.programs.ccache.cacheDir
  ];
}