{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  userPackages = with pkgs; [
    yazi
    starship
    zoxide
    fzf
    eza
    fastfetch
    tmux
    btop
    fd
    ripgrep
    jq
    yq
    gh
    mergiraf
    ast-grep
    tree-sitter
    nixd
    nixfmt
    rustup
    fnm
    uv
    bitwarden-cli
    chezmoi
    inputs.mineral.packages.${system}.default
  ];
in
{
  options.miku.base.packages.userPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
  };

  config = {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      neovim
      curl
      wget
      mihomo
    ];
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    miku.base.packages.userPackages = userPackages;
  };
}
