{ ... }: {
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    serif = [
      "Noto Serif CJK SC"
      "Noto Serif"
    ];
    sansSerif = [
      "Noto Sans CJK SC"
      "Noto Sans"
    ];
    monospace = [ "Maple Mono NF CN" ];
    emoji = [ "Noto Color Emoji" ];
  };
}
