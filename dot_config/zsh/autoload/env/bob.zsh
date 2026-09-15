bob_env="$HOME/.local/share/bob/env/env.sh"
if [[ -r $bob_env ]]; then
  source $bob_env
fi
unset bob_env
