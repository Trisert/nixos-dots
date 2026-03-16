{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
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
  ];

  programs.firefox.enable = true;
}
