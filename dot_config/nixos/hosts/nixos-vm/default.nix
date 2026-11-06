{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.openssh.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;
  networking.firewall.trustedInterfaces = [ "mihomo" ];

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.extraLocales = [
    "zh_CN.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.fcitx5.waylandFrontend = true;
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    (fcitx5-rime.override { rimeDataPkgs = [ rime-ice ]; })
  ];

  miku.base.packages.enableGuiPackages = true;

  users.users.orzmiku = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = config.miku.base.packages.userPackages ++ [ ];
  };

  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.firefox.languagePacks = [ "zh-CN" ];

  system.stateVersion = "26.05";
}
