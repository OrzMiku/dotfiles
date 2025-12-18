#!/usr/bin/env bash

# === Configuration ===
DOTFILES_DIR="$HOME/dotfiles/home"
HOME_DIR="$HOME"
FILES_TO_LINK=(
  ".gtkrc-2.0"
  ".config/nvim"
  ".vimrc"
  ".bashrc"
)
DIRS_TO_LINK_RECURSIVELY=(
  ".config/fcitx5"
  ".config/fontconfig"
  ".config/gtk-3.0"
  ".config/gtk-4.0"
  ".config/niri"
  ".local/share/fcitx5/rime"
  ".ssh"
  ".vscode"
  ".config/Code"
  ".config/zed"
  ".config/mpv"
  ".config/systemd/user"
  ".config/autostart"
  ".local/share/dbus-1/services"
)

# === Function ===
link_file() {
  local src="$DOTFILES_DIR/$1"
  local dst="$HOME/$1"
  local dst_dir="$(dirname "$dst")"

  if [[ ! -d "$dst_dir" ]]; then
    echo "conflict: the directory $dst_dir does not exist."
    echo " 1) create directory"
    echo " 2) abort link"
    read -p "choice [1-2] (default: 1): " choice < /dev/tty
    choice=${choice:-1}

    case $choice in
      1)
        mkdir -p "$dst_dir"
        ;;
      2)
        echo "aborted: $1"
        return 0
        ;;
      *)
        echo "invalid choice, aborting."
        return 1
        ;;
    esac
  elif [[ -L "$dst_dir" ]]; then
    echo "conflict: parent directory $dst_dir is a symbolic link."
    echo " 1) skip (keep directory as symbolic link)"
    echo " 2) convert to recursive linking"
    read -p "choice [1-2] (default: 1): " choice < /dev/tty
    choice=${choice:-1}

    case $choice in
      1)
        echo "skipped: $1"
        return 0
        ;;
      2)
        rm "$dst_dir"
        mkdir -p "$dst_dir"
        echo "converted $dst_dir from symbolic link to directory"
        ;;
      *)
        echo "invalid choice, aborting."
        return 1
        ;;
    esac
  fi

  if [[ -L "$dst" && "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
    echo "skipped: $1 (already linked)"
    return 0
  fi

  if [[ -e "$dst" ]]; then
    echo "conflict: $dst already exists."
    echo " 1) skip"
    echo " 2) backup and replace"
    echo " 3) override"
    read -p "choice [1-3] (default: 1): " choice < /dev/tty
    choice=${choice:-1}

    case $choice in
      1)
        echo "skipped: $1"
        return 0
        ;;
      2)
        local backup="${dst}.backup.$(date +%s)"
        mv "$dst" "$backup"
        echo "backed up to: $backup"
        ;;
      3)
        rm -f "$dst"
        ;;
      *)
        echo "invalid choice, aborting."
        return 1
        ;;
    esac
  fi

  ln -sf "$src" "$dst"
  echo "$1 is linked."
}

link_directory_recursion() {
  local dir="$1"
  find "$DOTFILES_DIR/$dir" -type f,l | while read -r src_file; do
    local relative_path="${src_file#$DOTFILES_DIR/}"
    link_file "$relative_path"
  done
}

# === Main ===
echo "=== Linking individual files ==="
for file in "${FILES_TO_LINK[@]}"; do
  link_file "$file"
done

echo ""
echo "=== Linking directories recursively ==="
for dir in "${DIRS_TO_LINK_RECURSIVELY[@]}"; do
  echo "Processing directory: $dir"
  link_directory_recursion "$dir"
done

echo ""
echo "=== Done ==="
