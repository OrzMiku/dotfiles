bindkey -e

for module in ${ZDOTDIR:-$HOME}/autoload/interactive/*.zsh(N); do
  source "$module"
done
