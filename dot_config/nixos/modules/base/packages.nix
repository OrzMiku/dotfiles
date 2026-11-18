{
  lib,
  pkgs,
  ...
}:
let
  packages = import ../../shared/package-list.nix { inherit pkgs; };
in
{
  options.miku.base.packages.enableGuiPackages = lib.mkEnableOption "gui packages";

  config = {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = packages.system;
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    programs.direnv.enable = true;
  };
}
