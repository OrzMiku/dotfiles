{ inputs, ... }: {
  imports = [
    inputs.nix-index-database.darwinModules.nix-index
  ];
  programs.nh.flake = "/etc/nix-darwin";
}
