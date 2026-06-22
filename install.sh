#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${CLAUDE_FM_REPO:-https://github.com/cyberpapiii/claude-fm-terminal}"
INSTALL_DIR="${CLAUDE_FM_INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
claude-fm installer

Usage:
  curl -fsSL .../install.sh | sh
  ./install.sh [--dir DIR]

Options:
  --dir DIR   Install claude-fm to DIR (default: ~/.local/bin)
  --help      Show this help
EOF
}

have() {
  command -v "$1" >/dev/null 2>&1
}

install_deps() {
  case "$(uname -s)" in
    Darwin)
      if have brew; then
        brew install yt-dlp mpv
      else
        echo "Install Homebrew from https://brew.sh then re-run this installer." >&2
        exit 1
      fi
      ;;
    Linux)
      if have apt-get; then
        sudo apt-get update
        sudo apt-get install -y yt-dlp mpv
      elif have dnf; then
        sudo dnf install -y yt-dlp mpv
      elif have pacman; then
        sudo pacman -S --needed yt-dlp mpv
      else
        echo "Install yt-dlp and mpv with your package manager, then run: claude-fm doctor" >&2
      fi
      ;;
    MINGW*|MSYS*|CYGWIN*)
      if have winget; then
        winget install yt-dlp.yt-dlp mpv.net
      else
        echo "Install yt-dlp and mpv manually, then run: claude-fm doctor" >&2
      fi
      ;;
    *)
      echo "Unsupported OS. Install yt-dlp and mpv manually." >&2
      ;;
  esac
}

main() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dir)
        INSTALL_DIR="$2"
        shift 2
        ;;
      --help|-h)
        usage
        exit 0
        ;;
      *)
        echo "Unknown option: $1" >&2
        usage >&2
        exit 1
        ;;
    esac
  done

  mkdir -p "$INSTALL_DIR"

  if [[ -f "$SCRIPT_DIR/bin/claude-fm" ]]; then
    cp "$SCRIPT_DIR/bin/claude-fm" "$INSTALL_DIR/claude-fm"
  else
    curl -fsSL "${REPO_URL}/raw/main/bin/claude-fm" -o "$INSTALL_DIR/claude-fm"
  fi

  chmod +x "$INSTALL_DIR/claude-fm"

  if ! have yt-dlp || ! have mpv; then
    echo "Installing playback dependencies..."
    install_deps || true
  fi

  case ":$PATH:" in
    *":$INSTALL_DIR:"*) ;;
    *)
      echo
      echo "Add to your shell profile:"
      echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
      ;;
  esac

  echo
  echo "Installed claude-fm to $INSTALL_DIR/claude-fm"
  echo "Run: claude-fm"
}

main "$@"
