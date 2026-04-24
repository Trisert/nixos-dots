{
  config,
  pkgs,
  inputs,
  ...
}:

let
  llm-agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  home.packages = with pkgs; [
    nixfmt
    awww
    gh
    thunar
    statix # Nix linter
    llm-agents.pi
    llm-agents.default
    devenv
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default))
  ];
}
