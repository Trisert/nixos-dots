{
  config,
  pkgs,
  ...
}:

{
  hardware.bluetooth.enable = true;
  zramSwap.enable = true;
}
