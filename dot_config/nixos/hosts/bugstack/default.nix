{ pkgs, inputs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.orzmiku.packages = with pkgs; [
    inputs.mineral.packages.${system}.default
    telegram-desktop
    prismlauncher
  ];

  programs.steam.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  networking.hostName = "bugstack";

  system.stateVersion = "26.05";
}
