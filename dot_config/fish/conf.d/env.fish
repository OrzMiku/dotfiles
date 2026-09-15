fish_add_path --global --move ~/.local/bin

if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL $EDITOR
end

if command -q less
    set -gx PAGER less
end
