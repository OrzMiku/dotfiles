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
    nixpkgs.config.allowUnfree = true;

    home.packages =
      packages.system
      ++ packages.user
      ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux (
        with pkgs;
        [
          gcc
          trash-cli
        ]
      )
      ++ lib.optionals (pkgs.stdenv.hostPlatform.isLinux && config.miku.base.packages.enableGuiPackages) (
        with pkgs;
        [
          vscode
          wechat
          qq
          wemeet
          ghostty
          mpv
        ]
      )
      ++ lib.optionals enableFonts (import ../../shared/font-list.nix { inherit pkgs; });

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    fonts.fontconfig.enable = pkgs.stdenv.hostPlatform.isLinux && enableFonts;
    programs.direnv.enable = true;
  };
}
