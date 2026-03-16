{ config
, pkgs
, inputs
, ...
}:

{
  home.packages = with pkgs; [
    nixfmt
    swww
    gh
    pre-commit # For pre-commit hooks
    statix # Nix linter
  ];
}
