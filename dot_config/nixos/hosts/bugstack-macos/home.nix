{ inputs, pkgs, ... }:
{
  imports = [ ../../home/orzmiku ];

  home.packages = [
    pkgs.antigravity-cli
    inputs.mineral.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
