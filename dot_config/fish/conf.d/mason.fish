set -l data_home $XDG_DATA_HOME
set -l app_name $NVIM_APPNAME
test -n "$data_home"; or set data_home ~/.local/share
test -n "$app_name"; or set app_name nvim

set -l mason_bin_path "$data_home/$app_name/mason/bin"
if test -d $mason_bin_path
    fish_add_path --global $mason_bin_path
end
