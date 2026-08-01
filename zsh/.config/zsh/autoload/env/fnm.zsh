fnm_dir="$HOME/.local/share/fnm"
if [[ -x $fnm_dir/fnm ]]; then
  path=($fnm_dir $path)
  eval "$(fnm env --shell zsh)"
fi
unset fnm_dir
