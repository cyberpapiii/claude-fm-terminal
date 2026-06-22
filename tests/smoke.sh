#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN="$ROOT/bin/claude-fm"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

bash -n "$BIN" || fail "syntax check bin/claude-fm"
bash -n "$ROOT/install.sh" || fail "syntax check install.sh"

"$BIN" --version | grep -q 'claude-fm 0.2.0' || fail "--version"
"$BIN" --help | grep -q 'centered ASCII art' || fail "--help"
"$BIN" setup | grep -q 'chafa' || fail "setup includes chafa"

if command -v yt-dlp >/dev/null && command -v mpv >/dev/null && command -v ffmpeg >/dev/null && command -v chafa >/dev/null; then
  "$BIN" doctor | grep -q 'Ready' || fail "doctor when deps present"
else
  echo "SKIP: doctor with deps (yt-dlp/mpv/ffmpeg/chafa not installed)"
fi

tmp="$(mktemp -d -t claude-fm-smoke.XXXXXX)"
trap 'rm -rf "$tmp"' EXIT

frame="$tmp/frame.jpg"
ffmpeg -hide_banner -loglevel error -f lavfi -i testsrc=size=80x45:rate=1 -frames:v 1 -y "$frame"

rendered="$(
  # shellcheck source=/dev/null
  source "$BIN"
  render_frame "$frame" ascii
)"

case "$rendered" in
  *[A-Za-z0-9_\#\$\@%]*)
    ;;
  *)
    fail "ascii renderer produced no visible ASCII"
    ;;
esac

"$BIN" stop | grep -q 'No claude-fm sessions' || fail "stop when idle"

echo "OK: smoke tests passed"
