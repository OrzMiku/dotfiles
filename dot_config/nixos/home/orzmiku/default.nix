{ ... }: {
  imports = [ ../../modules/home ];

  home.username = "orzmiku";
  home.homeDirectory = "/home/orzmiku";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/orzmiku/.config/nixos";
  };
}
