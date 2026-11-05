{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [

  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
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
      {
        name = "abue-ammar/tinycast";
        trusted = true;
      }
    ];
    casks = [
      "tinycast"
      "tencent-meeting"
      "wechat"
      "crisp"
      "ghostty"
      "visual-studio-code"
      "helium-browser"
      "iina"
      "keka"
      "mos"
      "flclash"
      "pearcleaner"
      "utm"
      "docker-desktop"
    ];
  };

  environment.systemPackages = with pkgs; [
    bash
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
    ast-grep
    yq
    duckdb
    eza
  ];

  fonts.packages = with pkgs; [
    maple-mono.NF-CN
    lxgw-wenkai
    lxgw-neoxihei
  ];

  system.primaryUser = "orzmiku";
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  system.stateVersion = 6;
}
