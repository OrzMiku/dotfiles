for module in ${ZDOTDIR:-$HOME}/autoload/env/*.zsh(N); do
  source "$module"
done
