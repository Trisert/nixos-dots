{
  config,
  pkgs,
  inputs,
  ...
}:

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
    rust-analyzer
    adwaita-icon-theme
  ];
}
