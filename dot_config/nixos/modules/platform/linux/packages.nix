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
  options.miku.base.packages.enableGuiPackages = lib.mkEnableOption "gui packages";

  config = lib.mkMerge [
    {
      services.emacs.enable = lib.mkDefault true;
      environment.systemPackages = with pkgs; [ emacs ];
      miku.base.packages.userPackages = [ pkgs.gcc ];
      programs.nix-ld.enable = true;
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
      ];
    })
  ];
}
