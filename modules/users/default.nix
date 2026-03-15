{
  config,
  pkgs,
  ...
}:

{
  users.users.nicola = {
    isNormalUser = true;
    description = "nicola";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };
}
