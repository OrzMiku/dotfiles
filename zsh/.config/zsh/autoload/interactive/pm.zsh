antidote_dir=${ZDOTDIR:-$HOME}/.antidote
zsh_plugins_file=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ -d $antidote_dir ]] && [[ -f $zsh_plugins_file ]]; then
  source $antidote_dir/antidote.zsh
  antidote load $zsh_plugins_file
else
  # 手动触发，刻意的设计：仅当未安装 antidote 时定义此函数
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
