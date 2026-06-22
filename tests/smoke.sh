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

"$BIN" --version | grep -q 'claude-fm 0.1.7' || fail "--version"
"$BIN" --help | grep -q 'claude-fm stop' || fail "--help lists stop"
"$BIN" setup | grep -q 'yt-dlp' || fail "setup"

# bash 3.2 regression: build_mpv_args must not abort under set -e
/bin/bash -c '
  set -euo pipefail
  YTDLP_FORMAT="test"
  eval "$(awk "/^tct_geometry\\(\\)/,/^}/" "'"$BIN"'")"
  eval "$(awk "/^build_mpv_args\\(\\)/,/^}/" "'"$BIN"'")"
  build_mpv_args audio 0
  test ${#MPV_ARGS[@]} -gt 0
' || fail "bash 3.2 mpv args build"

if command -v yt-dlp >/dev/null && command -v mpv >/dev/null; then
  "$BIN" doctor | grep -q 'Ready' || fail "doctor when deps present"
else
  echo "SKIP: doctor with deps (yt-dlp/mpv not installed)"
fi

"$BIN" stop | grep -q 'No claude-fm sessions' || fail "stop when idle"

echo "OK: smoke tests passed"
