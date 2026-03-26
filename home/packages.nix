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
    swww
    gh
    thunar
    pre-commit # For pre-commit hooks
    statix # Nix linter
    llm-agents.pi
    llm-agents.hermes-agent
    devenv
    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default))
  ];
}
