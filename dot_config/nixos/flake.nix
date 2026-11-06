{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
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
