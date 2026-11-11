{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mineral = {
      url = "./pkgs/mineral/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { nixpkgs, nix-darwin, ... }@inputs:
    {
      nixosConfigurations."nixos-vm" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/base
          ./modules/platform/linux
          ./hosts/nixos-vm
        ];
      };

      nixosConfigurations."bugstack-t480s" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/base
          ./modules/platform/linux
          ./hosts/bugstack-t480s
        ];
      };

      nixosConfigurations."bugstack" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/base
          ./modules/platform/linux
          ./hosts/bugstack
        ];
      };

      darwinConfigurations."bugstack-macos" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/base
          ./modules/platform/darwin
          ./hosts/bugstack-macos
        ];
      };
    };
}
