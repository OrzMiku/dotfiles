{ pkgs, inputs, ... }:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.orzmiku.packages = [
    inputs.mineral.packages.${system}.default
  ];

  networking.hostName = "bugstack";

  system.stateVersion = "26.05";
}
