{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.miku.base.packages;
in
{
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];

  options.miku.base.packages.enableGuiPackages = lib.mkEnableOption "gui packages";

  config = lib.mkMerge [
    {
      services.emacs.enable = lib.mkDefault true;
      environment.systemPackages = with pkgs; [
        emacs
      ];
      miku.base.packages.userPackages = with pkgs; [
        gcc
        trash-cli
      ];
      programs.nix-ld.enable = true;
      programs.nix-index-database.comma.enable = true;
    }
    (lib.mkIf cfg.enableGuiPackages {
      environment.systemPackages = with pkgs; [
        papirus-icon-theme
        bibata-cursors
      ];
      miku.base.packages.userPackages = with pkgs; [
        vscode
        wechat
        qq
        wemeet
        ghostty
        mpv
      ];
    })
  ];
}
