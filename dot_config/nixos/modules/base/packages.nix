{
  config,
  lib,
  pkgs,
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
    duckdb
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
