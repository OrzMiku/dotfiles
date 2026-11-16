{ inputs, pkgs, ... }:
{
  imports = [ ../../home/orzmiku ];

  home.packages = [
    inputs.mineral.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
