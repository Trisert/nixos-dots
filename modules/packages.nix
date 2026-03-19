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
    (sddm-astronaut.override {
      embeddedTheme = "astronaut";
    })
    # Pre-commit hook tools
    nixfmt
  ];
}
