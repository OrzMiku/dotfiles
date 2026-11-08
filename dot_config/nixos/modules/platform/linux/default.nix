{ ... }: {
  imports = [
    ./boot.nix
    ./desktop.nix
    ./fonts.nix
    ./i18n.nix
    ./network.nix
    ./packages.nix
    ./users.nix
    ./memory.nix
  ];
}
