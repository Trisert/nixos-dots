{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nixfmt
    awww
    gh
    thunar
    statix # Nix linter
    codex
    devenv
  ];
}
