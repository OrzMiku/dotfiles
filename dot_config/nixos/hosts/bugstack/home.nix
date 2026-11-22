{ inputs, pkgs, ... }:
{
  imports = [ ../../home/orzmiku ];

  home.packages =
    (with pkgs; [
      vscode
      wechat
      qq
      wemeet
      ghostty
      mpv
      telegram-desktop
      prismlauncher
      inputs.mineral.packages.${stdenv.hostPlatform.system}.default
    ])
    ++ (import ../../shared/font-list.nix { inherit pkgs; });

  fonts.fontconfig.enable = true;
}
