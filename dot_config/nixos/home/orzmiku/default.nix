{ pkgs, ... }:
let
  homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/orzmiku" else "/home/orzmiku";
in
{
  imports = [ ../../modules/home ];

  home.username = "orzmiku";
  home.homeDirectory = homeDirectory;
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = [
      "--keep-since"
      "7d"
      "--keep"
      "5"
    ];
    flake = "${homeDirectory}/.config/nixos";
  };
}
