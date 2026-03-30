{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    opencode
    llama-cpp-cuda
    ripgrep
    claude-code
    mindustry-wayland
    antigravity
    (sddm-astronaut.override {
      embeddedTheme = "astronaut";
    })
  ];
}
