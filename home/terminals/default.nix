{
  config,
  pkgs,
  ...
}:

{
  programs.kitty = {
    enable = true;
  };

  programs.tofi = {
    enable = true;
  };
}
