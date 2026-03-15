{
  config,
  pkgs,
  ...
}:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      n = "nvim";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
