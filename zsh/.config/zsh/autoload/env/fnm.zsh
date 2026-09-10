fnm_dir="$HOME/.local/share/fnm"
npm_prefix="$HOME/.local/npm"
if [[ -x $fnm_dir/fnm ]]; then
  path=($fnm_dir $path)
  eval "$(fnm env --shell zsh)"
  path=("$npm_prefix/bin" $path)
fi
unset fnm_dir
