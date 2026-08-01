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

# antidote
antidote_dir=${ZDOTDIR:-$HOME}/.antidote
zsh_plugins_file=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ -d $antidote_dir ]] && [[ -f $zsh_plugins_file ]]; then
  source $antidote_dir/antidote.zsh
  antidote load $zsh_plugins_file
else
  zsh_pm_init() {
    if git clone --depth=1 \
      https://github.com/mattmc3/antidote.git \
      "${ZDOTDIR:-$HOME}/.antidote"; then
      source "${ZDOTDIR:-$HOME}/.zshrc"
      unfunction zsh_pm_init
    else
      print -u2 "failed to install .antidote"
      return 1
    fi
  }
fi
unset antidote_dir
unset zsh_plugins_file
