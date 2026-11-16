{
  lib,
  pkgs,
  ...
}:
let
  packages = import ../../shared/package-list.nix { inherit pkgs; };
in
{
  options.miku.base.packages.userPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
  };

  config = {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = packages.system;
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    miku.base.packages.userPackages = packages.user;
    programs.direnv.enable = true;
  };
}
