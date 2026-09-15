if [[ $TERM == xterm-kitty ]] && (($+commands[kitten])); then
  alias ssh='kitten ssh'
fi
