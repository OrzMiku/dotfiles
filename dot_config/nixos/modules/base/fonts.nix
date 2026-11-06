{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    maple-mono.NF-CN
    lxgw-wenkai
    lxgw-neoxihei
  ];
}
