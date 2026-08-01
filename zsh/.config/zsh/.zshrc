# env
for editor in nvim vim emacs nano vi; do
  if (($+commands[$editor])); then
    export EDITOR=$editor
    export VISUAL=$editor
    break
  fi
done

if (($+commands[less])); then
  export PAGER=less
fi

# alias
alias ll='ls -l'
alias la='ls -la'

if (($+commands['trash-put'])); then
  alias rm='trash-put'
  alias tl='trash-list'
  alias tr='trash-restore'
fi

# path
typeset -U path
path=(~/.local/bin $path)

# kitty
if [[ $TERM == xterm-kitty ]] && (($+commands[kitten])); then
  alias ssh='kitten ssh'
fi

# starship
if (($+commands[starship])); then
  eval "$(starship init zsh)"
fi

# fzf
if (($+commands[fzf])); then
  eval "$(fzf --zsh)"
fi

# mason
mason_bin_path="${XDG_DATA_HOME:-$HOME/.local/share}/${NVIM_APPNAME:-nvim}/mason/bin"
if [[ -d $mason_bin_path ]]; then
  path=($mason_bin_path $path)
fi
unset mason_bin_path
