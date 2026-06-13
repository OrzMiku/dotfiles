{ config, lib, ... }: {
  options.myConfig.hypervisor = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "qemu"
        "virtualbox"
        "vmware"
        "hyperv"
        "none"
      ]
    );
    default = "none";
    description = "which hypervisor this VM runs under, for guest integration";
  };
  config =
    let
      hv = config.myConfig.hypervisor;
    in
    lib.mkMerge [
      (lib.mkIf (hv == "qemu") {
        services.qemuGuest.enable = true;
      })
      (lib.mkIf (hv == "virtualbox") {
        virtualisation.virtualbox.guest.enable = true;
      })
      (lib.mkIf (hv == "vmware") {
        virtualisation.vmware.guest.enable = true;
      })
      (lib.mkIf (hv == "hyperv") {
        virtualisation.hypervGuest.enable = true;
      })
    ];
}
