{ inputs, ... }: {
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];
  programs.nh.flake = "/etc/nixos";
}
