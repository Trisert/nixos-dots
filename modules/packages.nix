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
      themeConfig = {
        Background = "${config.stylix.image}";
        Font = config.stylix.fonts.sansSerif.name;
      };
    })
  ];

  programs.firefox.enable = true;
}
