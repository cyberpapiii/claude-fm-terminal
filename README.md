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

Requires **yt-dlp**, **mpv**, **ffmpeg**, and **chafa**. The installer tries to install them for you.

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
claude-fm --color          # colored character art
claude-fm --stable         # lower FPS
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
| `ESC` | Quit |

## Commands

| Command | What it does |
| --- | --- |
| `claude-fm` | Play Claude FM (ASCII) |
| `claude-fm --audio` | Audio only (recommended for daily use) |
| `claude-fm stop` | Kill stuck playback sessions |
| `claude-fm doctor` | Check dependencies |
| `claude-fm setup` | Print dependency install command |
| `claude-fm --help` | Show help |

## How it works

`claude-fm` is a tiny bash wrapper around [yt-dlp](https://github.com/yt-dlp/yt-dlp), [ffmpeg](https://ffmpeg.org/), [chafa](https://github.com/hpjansson/chafa), and [mpv](https://mpv.io/).

- `yt-dlp` resolves the current YouTube media stream.
- `ffmpeg` extracts low-FPS frames.
- `chafa` renders centered ASCII characters in the terminal.
- `mpv` plays the audio in the background.

When Anthropic rotates the stream URL:

```bash
export CLAUDE_FM_URL="https://www.youtube.com/watch?v=..."
claude-fm
```

## Tips

Terminal video is fun but still a little experimental. If you want the reliable daily-driver experience, use `claude-fm --audio`.

## Platforms

- **macOS** — iTerm2, Terminal.app, Ghostty, Kitty, WezTerm, Cursor
- **Linux** — any modern terminal with true color
- **Windows** — Windows Terminal via Git Bash or WSL

## Manual dependency install

```bash
# macOS
brew install yt-dlp mpv
brew install ffmpeg chafa

# Debian / Ubuntu
sudo apt-get install yt-dlp mpv
sudo apt-get install ffmpeg chafa

# Fedora
sudo dnf install yt-dlp mpv
sudo dnf install ffmpeg chafa
```

## License

MIT — see [LICENSE](LICENSE).

Not affiliated with Anthropic. Uses public YouTube streams via yt-dlp.
