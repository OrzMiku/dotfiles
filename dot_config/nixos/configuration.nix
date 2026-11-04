{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://cache.nixos.org"
  ];

  nixpkgs.config.allowUnfree = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.openssh.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
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

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    maple-mono.NF-CN
    lxgw-wenkai
    lxgw-neoxihei
  ];
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    serif = [
      "Noto Serif CJK SC"
      "Noto Serif"
    ];
    sansSerif = [
      "Noto Sans CJK SC"
      "Noto Sans"
    ];
    monospace = [ "Maple Mono NF CN" ];
    emoji = [ "Noto Color Emoji" ];
  };

  users.users.orzmiku = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [
    ];
  };

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.firefox.enable = true;
  programs.firefox.languagePacks = [ "zh-CN" ];

  environment.systemPackages = with pkgs; [
    neovim
    wget
    catimg
    yazi
    starship
    fastfetch
    fd
    fzf
    ripgrep
    tree-sitter
    fnm
    uv
    bitwarden-cli
    git
    chezmoi
    tmux
    zoxide
    mihomo
    mergiraf
    nixd
    nixfmt
    btop
    gh
    jq
    rustup
    ast-grep
    yq
    eza
    gcc
    papirus-icon-theme
    bibata-cursors
    ghostty
    wechat
    wemeet
    qq
    vscode
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    NIXPKGS_OUTPATH = inputs.nixpkgs.outPath;
  };

  system.stateVersion = "26.05";
}
