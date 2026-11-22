{ lib, pkgs, ... }: {
  services.emacs.enable = lib.mkDefault true;
  environment.systemPackages = [ pkgs.emacs ];
}
