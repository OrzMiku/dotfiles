{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.miku.base.packages;
in
{
  config = lib.mkMerge [
    {
      services.emacs.enable = lib.mkDefault true;
      environment.systemPackages = with pkgs; [
        emacs
      ];
    }
    (lib.mkIf cfg.enableGuiPackages {
      environment.systemPackages = with pkgs; [
        papirus-icon-theme
        bibata-cursors
      ];
    })
  ];
}
