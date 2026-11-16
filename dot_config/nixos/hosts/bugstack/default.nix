{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  programs.steam.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  networking.hostName = "bugstack";

  system.stateVersion = "26.05";
}
