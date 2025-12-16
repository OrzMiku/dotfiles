#!/bin/bash

# Configuration parameters
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
SWITCH_INTERVAL=900                                       # 15 minutes = 900 seconds
SUPPORTED_FORMATS=("jpg" "jpeg" "png" "gif" "webp" "bmp") # Supported wallpaper formats

# Color output functions (enhances readability)
print_info() {
  echo -e "\033[1;34m[INFO]\033[0m $1"
}

print_error() {
  echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  print_error "Wallpaper directory does not exist: $WALLPAPER_DIR"
  print_error "Please create this directory and add wallpapers before retrying"
  exit 1
fi

# Collect all supported wallpaper files
wallpapers=()
for fmt in "${SUPPORTED_FORMATS[@]}"; do
  # Recursive search (remove -r flag for single-level search only)
  while IFS= read -r file; do
    wallpapers+=("$file")
  done < <(find "$WALLPAPER_DIR" -type f -iname "*.$fmt" 2>/dev/null)
done

# Check if any wallpapers were found
if [ ${#wallpapers[@]} -eq 0 ]; then
  print_error "No supported wallpaper files found in $WALLPAPER_DIR"
  print_error "Supported formats: ${SUPPORTED_FORMATS[*]}"
  exit 1
fi

print_info "Found ${#wallpapers[@]} wallpapers. Starting slideshow (changing every 15 minutes)"
print_info "Press Ctrl+C to stop the script"

# Cleanup residual swaybg processes
cleanup() {
  if [ -n "$SWAYBG_PID" ] && ps -p "$SWAYBG_PID" >/dev/null 2>&1; then
    print_info "Stopping swaybg process..."
    kill "$SWAYBG_PID" >/dev/null 2>&1
  fi
  print_info "Script exited successfully"
  exit 0
}

# Capture Ctrl+C signal
trap cleanup SIGINT SIGTERM

# Infinite loop for wallpaper rotation
while true; do
  # Randomly select a wallpaper
  random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

  # Stop previous swaybg process if it exists
  if [ -n "$SWAYBG_PID" ] && ps -p "$SWAYBG_PID" >/dev/null 2>&1; then
    kill "$SWAYBG_PID" >/dev/null 2>&1
  fi

  # Start new swaybg process with selected wallpaper
  print_info "Current wallpaper: $random_wallpaper"
  swaybg -i "$random_wallpaper" -m fill &
  SWAYBG_PID=$!

  # Wait for specified interval (15 minutes)
  sleep "$SWITCH_INTERVAL"
done
