{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nixfmt
    swww
    gh
  ];
}
