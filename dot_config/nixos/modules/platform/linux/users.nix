{ config, pkgs, ... }: {
  programs.zsh.enable = true;

  users.users.orzmiku = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = config.miku.base.packages.userPackages;
  };
}
