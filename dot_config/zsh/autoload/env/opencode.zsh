opencode_dir="$HOME/.opencode/bin"
if [[ -d $opencode_dir ]]; then
  path=($opencode_dir $path)
fi
unset opencode_dir
