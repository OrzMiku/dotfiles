{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.bash ];
  fonts.packages = import ../../../shared/font-list.nix { inherit pkgs; };
}
