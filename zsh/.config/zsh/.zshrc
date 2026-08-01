# path
typeset -U path
path=(~/.local/bin $path)

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

# bob
bob_env="$HOME/.local/share/bob/env/env.sh"
if [[ -r $bob_env ]]; then
  source $bob_env
fi
unset bob_env

# fnm
fnm_dir="$HOME/.local/share/fnm"
if [[ -x $fnm_dir/fnm ]]; then
  path=($fnm_dir $path)
  eval "$(fnm env --shell zsh)"
fi
unset fnm_dir

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
      source "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh"
      antidote load "${ZDOTDIR:-$HOME}/.zsh_plugins"
      unfunction zsh_pm_init
    else
      print -u2 "failed to install .antidote"
      return 1
    fi
  }
fi
unset antidote_dir
unset zsh_plugins_file
