{
  config,
  pkgs,
  ...
}:

{
  hardware.bluetooth.enable = true;
  zramSwap = {
    enable = true;
    memoryMaxSize = "8G";
    algorithm = "zstd";
  };
}
