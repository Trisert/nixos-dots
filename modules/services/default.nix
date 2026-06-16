{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 8;
    freeSwapThreshold = 15;
  };

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
  };

  services.printing.enable = true;

  programs.ssh.startAgent = true;

  programs.steam.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.hermes-agent = {
    enable = true;
    settings = {
      model = {
        provider = "openai";
        default = "llama";
      };
    };
    environment = {
      OPENAI_BASE_URL = "http://localhost:8080/v1";
    };
    addToSystemPackages = true;
  };
}
