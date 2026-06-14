{
  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-26.05&shallow=1";
    nixpkgs-unstable.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
  };
  outputs =
    { nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      unstableOverlay = final: prev: {
        unstable = import nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
      };
      pkgs = nixpkgs.legacyPackages.${system};
      mkHost =
        {
          hostname,
          system ? "x86_64-linux",
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            { nixpkgs.overlays = [ unstableOverlay qqOverlay ]; }
            { nixpkgs.config.allowUnfree = true; }
            ./modules/common.nix
            ./hosts/${hostname}/configuration.nix
            ./hosts/${hostname}/hardware-configuration.nix
          ]
          ++ extraModules;
        };
      qqOverlay = final: prev: {
        qq = prev.qq.overrideAttrs (old: {
          src = prev.fetchurl {
            url = "https://qqdl.gtimg.cn/qqfile/QQNT/9.9.31/release/00e6a3e7/QQ_3.2.29_260528_amd64_01.deb";
            hash = "sha256-HjgoB5ZzyUmUvA9HgNXYUoZHY5kgZZhi1J0cLyoZjiU=";
          };

          installPhase =
            prev.lib.replaceStrings [ "rm -r $out/opt/QQ/resources/app/sharp-lib" ] [ "" ]
              old.installPhase;
        });
      };
    in
    {
      nixosConfigurations = {
        "vm-nixy" = mkHost {
          hostname = "vm-nixy";
          extraModules = [ ./modules/vm-guest.nix ];
        };
        "pc-t480s" = mkHost {
          hostname = "pc-t480s";
          extraModules = [ ];
        };
      };
    };
}
