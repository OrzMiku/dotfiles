status is-interactive; or return

alias ll='ls -l'
alias la='ls -la'

if command -q trash-put
    alias tl='trash-list'
    alias tr='trash-restore'
end

if test "$TERM" = xterm-kitty; and command -q kitten
    alias ssh='kitten ssh'
end
