{ config, ... }: {
  users.users.orzmiku.packages = config.miku.base.packages.userPackages;
  system.primaryUser = "orzmiku";
}
