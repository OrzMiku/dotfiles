{ inputs, pkgs, ... }:
{
  imports = [ ../../home/orzmiku ];

  miku.base.packages.enableGuiPackages = true;
  home.packages = [
    inputs.mineral.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.telegram-desktop
    pkgs.prismlauncher
  ];
}
