{ pkgs }: {
  user = with pkgs; [
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
  ];
  system = with pkgs; [
    git
    git-lfs
    neovim
    curl
    wget
  ];
}
