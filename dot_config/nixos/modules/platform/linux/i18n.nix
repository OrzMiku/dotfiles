{ pkgs, ... }: {
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
}
