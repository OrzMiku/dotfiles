{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-vm";

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  system.stateVersion = "26.05";
}
