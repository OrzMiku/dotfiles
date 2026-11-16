{
  pkgs,
  ...
}:
let
  packages = import ../../shared/package-list.nix { inherit pkgs; };
in
{
  config = {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = packages.system;
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    programs.direnv.enable = true;
  };
}
