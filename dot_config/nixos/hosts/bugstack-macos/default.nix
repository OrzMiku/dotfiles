{
  inputs,
  ...
}:
let
  system = "aarch64-darwin";
in
{
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
  ];
  nixpkgs.hostPlatform = system;
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;
}
