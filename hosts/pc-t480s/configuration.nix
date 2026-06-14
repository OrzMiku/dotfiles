{ lib, pkgs, ... }:

{
  networking.hostName = "pc-t480s";

  programs.fish.enable = true;

  users.users.orzmiku = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      bibata-cursors
      papirus-icon-theme
      google-chrome
      qq
      wl-clipboard
      sparkle
    ];
  };

  security.wrappers.mihomo = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_raw,cap_net_admin,cap_sys_nice+ep";
    source = "${pkgs.sparkle}/lib/sparkle/resources/sidecar/mihomo";
  };

  environment.systemPackages = with pkgs; [
  ];

  virtualisation.podman.enable = true;

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.firefox.enable = true;
  hardware.bluetooth.enable = true;

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      (fcitx5-rime.override {
        rimeDataPkgs = with pkgs; [
          rime-data
          rime-ice
        ];
      })
    ];
    fcitx5.waylandFrontend = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    maple-mono.NF
  ];

  fonts.fontconfig.defaultFonts = {
    emoji = [ "Noto Color Emoji" ];
    serif = [
      "Noto Serif CJK SC"
      "Noto Serif"
    ];
    sansSerif = [
      "Noto Sans CJK SC"
      "Noto Sans"
    ];
    monospace = [
      "Maple Mono NF"
      "Noto Mono"
      "Noto Mono CJK SC"
    ];
  };

}
