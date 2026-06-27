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
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables.LLAMA_CPP_API_KEY = "sk-no-key-required";

  environment.systemPackages = with pkgs; [
    wget
    opencode
    llama-cpp-cuda
    ik-llama-cpp-cuda
    ripgrep
    discord
    gemini-cli
    nodejs
    grim
    slurp
    wl-clipboard
    llm-agents.default
    adwaita-icon-theme
  ];
}
