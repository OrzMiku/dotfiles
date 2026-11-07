{ ... }: {
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  miku.base.packages.enableGuiPackages = true;

  programs.firefox.enable = true;
  programs.firefox.languagePacks = [ "zh-CN" ];
}
