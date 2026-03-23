{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    opencode
    llama-cpp-cuda
    ripgrep
    claude-code
    mindustry-wayland
    (sddm-astronaut.override {
      embeddedTheme = "astronaut";
    })
  ];
}
