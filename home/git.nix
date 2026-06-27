{ config
, pkgs
, ...
}:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Nicola Destro";
      user.email = "nicolade03@gmail.com";
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
}
