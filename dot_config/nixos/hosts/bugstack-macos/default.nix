{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./homebrew.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.orzmiku.packages = config.miku.base.packages.userPackages ++ [ ];

  system.primaryUser = "orzmiku";
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;
}
