{ ... }: {
  services.openssh.enable = true;

  networking.networkmanager.enable = true;
  networking.firewall.trustedInterfaces = [ "Meta" ];
}
