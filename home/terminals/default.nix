{
  config,
  pkgs,
  ...
}:

{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 10;
    };
  };

  programs.tofi = {
    enable = true;
  };
}
