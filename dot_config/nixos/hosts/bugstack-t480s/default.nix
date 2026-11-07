{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "bugstack-t480s";

  system.stateVersion = "26.05";
}
