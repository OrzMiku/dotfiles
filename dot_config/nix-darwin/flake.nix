{
  description = "nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    flyline.url = "github:HalFrgrd/flyline";
  };
  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      neovim-nightly-overlay,
      flyline,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.overlays = [
            neovim-nightly-overlay.overlays.default
          ];
          programs.flyline.enable = true;

          homebrew = {
            enable = true;
            onActivation = {
              autoUpdate = true;
              cleanup = "zap";
              extraFlags = [ "-v" ];
            };
            taps = [
              {
                name = "chen08209/tap";
                trusted = true;
              }
            ];

            casks = [
              "crisp"
              "ghostty"
              "visual-studio-code"
              "helium-browser"
              "iina"
              "keka"
              "mos"
              "flclash"
              "pearcleaner"
            ];
          };

          environment.systemPackages = with pkgs; [
            bash
            catimg
            yazi
            neovim
            starship
            fastfetch
            fd
            fzf
            ripgrep
            tree-sitter
            fnm
            uv
            bitwarden-cli
            git
            chezmoi
            tmux
            zoxide
            mihomo
            mergiraf
            nixd
            nixfmt
            btop
            gh
            jq
            rustup
          ];

          fonts.packages = with pkgs; [
            maple-mono.NF-CN
            lxgw-wenkai
            lxgw-neoxihei
          ];

          nix.settings = {
            experimental-features = "nix-command flakes";
            substituters = [
              "https://mirrors.ustc.edu.cn/nix-channels/store"
              "https://cache.nixos.org"
            ];
          };

          system.primaryUser = "orzmiku";
          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 6;
        };
    in
    {
      darwinConfigurations."bugstack-macos" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          inputs.flyline.nixosModules.default
        ];
      };
    };
}
