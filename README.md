# claude-fm

Claude FM in your terminal. Play the official Claude FM YouTube livestream — or any YouTube stream — as ASCII art, with one command.

No browser tab. No video page. Just terminal vibes.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/cyberpapiii/claude-fm-terminal/main/install.sh | sh
```

Or clone and install locally:

```bash
git clone https://github.com/cyberpapiii/claude-fm-terminal.git
cd claude-fm-terminal
./install.sh
```

Requires **yt-dlp** and **mpv**. The installer tries to install them for you.

## Run

```bash
claude-fm
```

ASCII art by default. For background music while you work:

```bash
claude-fm --audio
```

Other modes:

```bash
claude-fm --color          # color unicode blocks
claude-fm --stable         # fewer glitches (lower res)
claude-fm "https://youtube.com/watch?v=..."   # any YouTube URL
```

Stuck or running in another tab?

```bash
claude-fm stop
```

## Controls

| Key | Action |
| --- | --- |
| `q` | Quit |
| `space` | Pause / resume |
| `m` | Mute |
| `9` / `0` | Volume down / up |

## Commands

| Command | What it does |
| --- | --- |
| `claude-fm` | Play Claude FM (ASCII) |
| `claude-fm --audio` | Audio only (recommended for daily use) |
| `claude-fm stop` | Kill stuck playback sessions |
| `claude-fm doctor` | Check yt-dlp + mpv |
| `claude-fm setup` | Print dependency install command |
| `claude-fm --help` | Show help |

## How it works

`claude-fm` is a tiny bash wrapper around [yt-dlp](https://github.com/yt-dlp/yt-dlp) and [mpv](https://mpv.io/). It plays the Claude FM livestream by default, caps quality for terminal performance, and renders with mpv's `tct` terminal output.

When Anthropic rotates the stream URL:

```bash
export CLAUDE_FM_URL="https://www.youtube.com/watch?v=..."
claude-fm
```

## Tips

Terminal video is fun but a bit janky. If you see glitches, try `claude-fm --stable` or `claude-fm --audio`.

## Platforms

- **macOS** — iTerm2, Terminal.app, Ghostty, Kitty, WezTerm, Cursor
- **Linux** — any modern terminal with true color
- **Windows** — Windows Terminal via Git Bash or WSL

## Manual dependency install

```bash
# macOS
brew install yt-dlp mpv

# Debian / Ubuntu
sudo apt-get install yt-dlp mpv

# Fedora
sudo dnf install yt-dlp mpv
```

## License

MIT — see [LICENSE](LICENSE).

Not affiliated with Anthropic. Uses public YouTube streams via yt-dlp.
