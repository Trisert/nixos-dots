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

  services.fstrim.enable = true;

  services.printing.enable = true;

  programs.ssh.startAgent = true;

  programs.steam.enable = true;
}
