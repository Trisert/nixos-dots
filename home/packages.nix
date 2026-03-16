{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    nixfmt
    swww
    gh
  ];
}
