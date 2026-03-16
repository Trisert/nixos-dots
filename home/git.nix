{ config
, pkgs
, ...
}:

{
  programs.git = {
    enable = true;
    settings.user.name = "Nicola Destro";
    settings.user.email = "nicolade03@gmail.com";
    settings = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}
