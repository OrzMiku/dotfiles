{
  description = "Nix";
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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    {
      homeModules.base = import ./modules/home;

      homeConfigurations."orzmiku" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          inputs.nix-index-database.homeModules.default
          ./home/orzmiku/generic-linux.nix
        ];
      };

      homeConfigurations."orzmiku@bugstack" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          inputs.nix-index-database.homeModules.default
          ./hosts/bugstack/home.nix
        ];
      };

      homeConfigurations."orzmiku@bugstack-macos" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          inputs.nix-index-database.homeModules.default
          ./hosts/bugstack-macos/home.nix
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
