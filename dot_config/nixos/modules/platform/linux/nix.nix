{ inputs, ... }: {
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];
  programs.nh.flake = "/etc/nixos";
  programs.nix-ld.enable = true;
  programs.nix-index-database.comma.enable = true;
}
