{
  config,
  lib,
  pkgs,
  ...
}:
{
  fonts.packages = lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin || config.miku.base.packages.enableGuiPackages) (
    import ../../shared/font-list.nix { inherit pkgs; }
  );
}
