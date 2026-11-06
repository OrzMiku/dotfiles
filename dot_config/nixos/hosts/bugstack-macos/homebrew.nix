{ ... }: {
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
      {
        name = "d12frosted/emacs-plus";
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
      "emacs-plus-app"
    ];
  };
}
