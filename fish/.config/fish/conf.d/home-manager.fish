set -l hm_session_vars "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

if test -x "$HOME/.nix-profile/bin/babelfish"; and test -f $hm_session_vars
    "$HOME/.nix-profile/bin/babelfish" < $hm_session_vars | source
end
