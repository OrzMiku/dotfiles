{ pkgs, ... }: {
  imports = [ ./fonts.nix ];

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    papirus-icon-theme
    bibata-cursors
  ];

  programs.firefox.enable = true;
  programs.firefox.languagePacks = [ "zh-CN" ];
}
