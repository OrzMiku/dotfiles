{
  lib,
  pkgs,
  ...
}:
let
  packages = import ../../shared/package-list.nix { inherit pkgs; };
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages =
    packages.user
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux (
      with pkgs;
      [
        gcc
        trash-cli
      ]
    )
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin (
      with pkgs;
      [
        docker
        colima
      ]
      ++ import ../../shared/font-list.nix { inherit pkgs; }
    );

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.direnv.enable = true;
}
