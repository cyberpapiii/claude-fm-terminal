---
title: "refactor: Simplify and polish claude-fm CLI"
type: refactor
date: 2026-06-22
---

# refactor: Simplify and polish claude-fm CLI

## Summary

Flatten `bin/claude-fm`, sync README/help with shipped behavior, harden `stop`, and add a bash 3.2 regression check — without changing user-facing playback behavior.

## Problem Frame

Post-review cleanup: dead abstractions (`pick_vo`, null-byte arg piping), stale docs, overly broad `stop` matching, and help listing removed keybindings.

## Requirements

- R1. `mpv` args built in-process (no null-delimited subprocess read loop).
- R2. README documents ASCII default, `--audio`, `--stop`, and `CLAUDE_FM_URL`.
- R3. Help text matches actual keybindings (no `f` fullscreen).
- R4. `claude-fm stop` only targets this tool's mpv/bash processes.
- R5. Smoke test guards bash 3.2 `mpv_extra_args` regression.
- R6. Behavior preserved: ascii default, color, audio, stable, doctor, setup, stop.

## Key Technical Decisions

- KTD1. Keep `--ascii` flag for explicitness even though it matches default.
- KTD2. Remove `play` subcommand — `claude-fm` with flags/URL is sufficient.
- KTD3. Use PID file or narrow pgrep patterns for `stop` (match install path + stream URL).

## Implementation Units

### U1. Simplify `bin/claude-fm`

**Goal:** Flatten mpv arg assembly; remove `pick_vo`; tighten `stop`.

**Files:** `bin/claude-fm`

**Test scenarios:**
- `claude-fm --version` prints 0.1.7
- `mpv_extra_args` produces non-empty args under `/bin/bash` for audio mode
- `claude-fm stop` on idle reports no sessions

### U2. Docs and tests

**Goal:** README + smoke test updates.

**Files:** `README.md`, `tests/smoke.sh`

**Verification:** `./tests/smoke.sh` passes; shellcheck clean.
