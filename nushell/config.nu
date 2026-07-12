$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

let vendor_autoload_dir = ($nu.vendor-autoload-dirs | first)
mkdir $vendor_autoload_dir

# starship
if not (which starship | is-empty) {
  starship init nu | save -f ($vendor_autoload_dir | path join "starship.nu")
}

# fzf
if not (which starship | is-empty) {
  fzf --nushell | save -f ($vendor_autoload_dir | path join "fzf.nu")
}
