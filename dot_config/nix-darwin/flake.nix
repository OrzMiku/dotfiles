{
  description = "nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.hostPlatform = "aarch64-darwin";

          homebrew = {
            enable = true;
            onActivation = {
              autoUpdate = true;
              cleanup = "zap";
              extraFlags = [ "-v" ];
            };
            casks = [
              "ghostty"
              "visual-studio-code"
              "helium-browser"
              "iina"
              "keka"
            ];
          };

          environment.systemPackages = with pkgs; [
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
        ];
      };
    };
}
