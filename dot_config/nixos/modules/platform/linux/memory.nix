{ lib, config, ... }:
let
  defaults = lib.mapAttrs (_name: value: lib.mkDefault value);
in
{
  zramSwap = defaults {
    enable = true;
    memoryPercent = 100;
    memoryMax = 8 * 1024 * 1024 * 1024;
  };

  boot.kernel.sysctl = lib.mkIf config.zramSwap.enable (defaults {
    "vm.swappiness" = 180;
    "vm.page-cluster" = 0;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  });
}
