set -l nix_profile_script "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

if test -x "$HOME/.nix-profile/bin/babelfish"
    if test -f $hm_session_vars
        $HOME/.nix-profile/bin/babelfish < $nix_profile_script | source
    end
end
