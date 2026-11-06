{
  lib,
  pkgs,
  inputs,
  ...
}:
let
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
    inputs.mineral.packages.${pkgs.system}.default
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
