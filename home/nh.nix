{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.nh = {
    enable = true;
    flake = toString inputs.self;
  };
}