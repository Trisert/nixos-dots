{
  config,
  pkgs,
  ...
}:

{
  hardware.bluetooth.enable = true;
  zramSwap = {
    enable = true;
    memoryMax = 8 * 1024 * 1024 * 1024; # 8GB
    algorithm = "zstd";
  };
}
