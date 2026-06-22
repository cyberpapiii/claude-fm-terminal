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

"$BIN" --version | grep -q 'claude-fm 0.1.0' || fail "--version"
"$BIN" --help | grep -q 'claude-fm --ascii' || fail "--help"
"$BIN" setup | grep -q 'yt-dlp' || fail "setup"

if command -v yt-dlp >/dev/null && command -v mpv >/dev/null; then
  "$BIN" doctor | grep -q 'Ready' || fail "doctor when deps present"
else
  echo "SKIP: doctor with deps (yt-dlp/mpv not installed)"
fi

echo "OK: smoke tests passed"
