{
  config,
  lib,
  pkgs,
  ...
}:
let
  packages = import ../../shared/package-list.nix { inherit pkgs; };
  enableFonts = pkgs.stdenv.hostPlatform.isDarwin || config.miku.base.packages.enableGuiPackages;
in
{
  options.miku.base.packages.enableGuiPackages = lib.mkEnableOption "gui packages";

  config = {
    home.packages =
      packages.system
      ++ packages.user
      ++ lib.optionals enableFonts (import ../../shared/font-list.nix { inherit pkgs; });

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    fonts.fontconfig.enable = pkgs.stdenv.hostPlatform.isLinux && enableFonts;
    programs.direnv.enable = true;
  };
}
