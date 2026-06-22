# claude-fm

Claude FM in your terminal. Play the official Claude FM YouTube livestream — or any YouTube stream — as color block art or ASCII, with one command.

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

That's it. Auto-detects your terminal and picks the best renderer.

```bash
claude-fm --ascii          # classic ASCII look
claude-fm --color          # color unicode blocks (default on most terminals)
claude-fm --audio          # audio only
claude-fm "https://youtube.com/watch?v=..."   # any YouTube URL
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
| `claude-fm` | Play Claude FM (auto mode) |
| `claude-fm doctor` | Check yt-dlp + mpv |
| `claude-fm setup` | Print dependency install command |
| `claude-fm --help` | Show help |

## How it works

`claude-fm` is a tiny bash wrapper around [yt-dlp](https://github.com/yt-dlp/yt-dlp) and [mpv](https://mpv.io/). It resolves the current Claude FM livestream via `@anthropic/live`, caps quality for terminal performance, and renders with mpv's terminal video outputs (`tct`, `kitty`).

## Platforms

- **macOS** — iTerm2, Terminal.app, Ghostty, Kitty, WezTerm
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
