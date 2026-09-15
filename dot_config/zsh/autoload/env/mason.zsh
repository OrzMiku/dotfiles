mason_bin_path="${XDG_DATA_HOME:-$HOME/.local/share}/${NVIM_APPNAME:-nvim}/mason/bin"
if [[ -d $mason_bin_path ]]; then
  path=($mason_bin_path $path)
fi
unset mason_bin_path
