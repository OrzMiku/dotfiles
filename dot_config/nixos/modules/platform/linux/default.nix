{ ... }: {
  imports = [
    ./boot.nix
    ./desktop.nix
    ./i18n.nix
    ./network.nix
    ./packages.nix
    ./users.nix
    ./memory.nix
    ./nix.nix
  ];
}
