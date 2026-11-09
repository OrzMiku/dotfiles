{
  inputs,
  ...
}:
let
  system = "aarch64-darwin";
in
{
  nixpkgs.hostPlatform = system;
  users.users.orzmiku.packages = [
    inputs.mineral.packages.${system}.default
  ];
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;
}
