{ ... }: {
  imports = [
    ./homebrew.nix
    ./nix.nix
    ./packages.nix
    ./users.nix
    ./security.nix
  ];
}
