alias ll='ls -l'
alias la='ls -la'

# quoted subscript: shfmt's zsh parser misreads the hyphen as subtraction
if (($+commands['trash-put'])); then
  alias rm='trash-put'
  alias tl='trash-list'
  alias tr='trash-restore'
fi
