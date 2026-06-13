{ pkgs, ... }:
{
  zramSwap.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "zh_CN.UTF-8/UTF-8" ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://cache.nixos.org"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    nixd
    nixfmt
    unstable.neovim
    wget
    git
    fd
    ripgrep
    fzf
  ];

  system.stateVersion = "26.05";
}
