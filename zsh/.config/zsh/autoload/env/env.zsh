typeset -U path
path=(~/.local/bin $path)

if (($+commands[nvim])); then
  export EDITOR=nvim
  export VISUAL=$EDITOR
fi

if (($+commands[less])); then
  export PAGER=less
fi
