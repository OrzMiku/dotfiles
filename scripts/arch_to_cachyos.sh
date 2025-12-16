#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TEMP_DIR=$(mktemp -d)
readonly REPO_URL="https://mirror.cachyos.org/cachyos-repo.tar.xz"

cleanup() {
  if [[ -d "$TEMP_DIR" ]]; then
    echo "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
  fi
}

trap cleanup EXIT

preinstall() {
  if [[ $("$SCRIPT_DIR/utils/is_arch.sh") -eq 0 ]]; then
    echo "This script can only run on Arch Linux distributions."
    exit 1
  fi

  if [[ $EUID -ne 0 ]]; then
    echo "This script requires root privileges to run."
    exit 1
  fi

  if [[ ! -x $(command -v curl) ]]; then
    echo "$curl is missing, try installing it using `sudo pacman -Sy curl`."
    exit 1
  fi
}

install() {
  echo "Downloading CachyOS repository configuration..."
  cd $TEMP_DIR || exit 1

  if ! curl -OJ "$REPO_URL"; then
    echo "Failed to download CachyOS repository files."
    exit 1
  fi

  echo "Extracting archive..."
  if ! tar -xvf cachyos-repo.tar.xz; then
    echo "Failed to extract archive."
    exit 1
  fi

  cd cachyos-repo || exit 1

  echo "Installing CachyOS repository..."
  if ! ./cachyos-repo.sh; then
    echo "Failed to install CachyOS repository."
    exit 1
  fi

  echo "CachyOS repository installed successfully!"

  echo "Synchronizing package databases..."
  if ! pacman -Sy; then
    echo "Failed to sync package databases."
    exit 1
  fi

  echo "Installing CachyOS Kernel and settings..."
  echo "This may take a few minutes depending on your connection speed."

  if ! pacman -S --needed linux-cachyos cachyos-settings; then
    echo "Failed to install CachyOS Kernel and settings."
    echo "Attempting to remove partially installed packages..."
    pacman -Rsn --noconfirm linux-cachyos cachyos-settings 2>/dev/null || true
    echo "Please check your internet connection and try again."
    exit 1
  fi

  echo "CachyOS Kernel and settings installed successfully!"
  echo "Please reboot your system to use the new CachyOS kernel."
}


preinstall
install
