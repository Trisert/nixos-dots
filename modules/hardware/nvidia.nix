{ config
, pkgs
, inputs
, ...
}:

{
  hardware.graphics = {
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  systemd.services.nvidia-tdp = {
    description = "Set NVIDIA TDP limit";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/nvidia-smi -pl 125 -i 0";
    };
  };
}
