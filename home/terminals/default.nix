{
  config,
  pkgs,
  ...
}:

{
  programs.kitty = {
    enable = true;
    settings = {
      include = "themes/noctalia.conf";
    };
  };
}
