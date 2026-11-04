{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    flyline.url = "github:HalFrgrd/flyline";
  };
  outputs =
    { nixpkgs, nix-darwin, ... }@inputs:
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos
          ./modules/base/nix.nix
          inputs.flyline.nixosModules.default
        ];
      };

      darwinConfigurations."bugstack-macos" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/bugstack-macos
          ./modules/base/nix.nix
          inputs.flyline.nixosModules.default
        ];
      };
    };
}
