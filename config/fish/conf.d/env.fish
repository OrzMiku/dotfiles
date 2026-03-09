if status is-interactive
  # neovim
  set -l NVIM_PATH $HOME/.local/share/bob/nvim-bin
  fish_add_path $NVIM_PATH
  set -gx EDITOR $NVIM_PATH/nvim
  set -gx VISUAL $NVIM_PATH/nvim

  # fnm
  fish_add_path $HOME/.local/share/fnm

  # bun
  fish_add_path $HOME/.bun/bin

  # opencode
  fish_add_path $HOME/.opencode/bin

end
