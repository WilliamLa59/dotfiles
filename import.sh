set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}" # repo root
SRC_BASE="$HOME/.config"               # where we import from
PKG=".config"                          # we keep configs under dotfiles/.config
TARGET="$HOME"                         # where stow will link to

usage() {
  echo "usage: $(basename "$0") <dir> [<dir> ...]"
  echo "example: $(basename "$0") fastfetch zsh hypr waybar"
}

# tiny helper to ensure gnu stow exists
need_stow() {
  if ! command -v stow >/dev/null 2>&1; then
    echo "error: 'stow' not found. install it (e.g., 'sudo pacman -S stow')." >&2
    exit 1
  fi
}

# copy ~/.config/<name> -> ~/dotfiles/.config/<name>
import_one() {
  local name="$1"
  local src="$SRC_BASE/$name"
  local dst="$DOTFILES/$PKG/$name"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "skip: $src does not exist"
    return
  fi

  mkdir -p "$(dirname "$dst")"

  # if destination exists, merge; otherwise move
  if [[ -e "$dst" ]]; then
    echo "merge: $src -> $dst"
    rsync -a --delete "$src"/ "$dst"/
    rm -rf "$src"
  else
    echo "move:  $src -> $dst"
    mv "$src" "$dst"
  fi
}

# run stow so ~/.config/<name> becomes a symlink to the repo
restow() {
  echo "stowing package '$PKG' from $DOTFILES into $TARGET"
  (cd "$DOTFILES" && stow -t "$TARGET" "$PKG")
}

main() {
  if [[ $# -lt 1 ]]; then
    usage
    exit 1
  fi
  need_stow
  mkdir -p "$DOTFILES/$PKG"

  # loop through params (e.g., fastfetch, zsh, hypr)
  for name in "$@"; do
    import_one "$name"
  done

  # stow the .config package
  restow

  echo "done."
}

main "$@"
