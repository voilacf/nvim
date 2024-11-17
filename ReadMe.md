#  MacOS Nvim Config

- lazy used as package manager
- config written in Lua
- setup for macOs (still working on optimized version)

---

## Setup

located in

```bash
~/.config/nvim/init.lua
```

---

### MacOs adjustments for enabling true color support:

1. Adjust `~/.zshrc` environment variables:

```bash
$TERM = xterm-256color
$COLORTERM = truecolor
```

then run

```bash
source ~/.zshrc
```

2. Adjust `~/.tmux.conf`:

```bash
set -g default-terminal "screen-256color"
set -g terminal-overrides "xterm*:Tc"

# Status bar customization, needed due to neon green highlighting
set-option -g status-bg black          # Background color (black)
set-option -g status-fg white          # Text color (white)
set-option -g status-style default     # Default styling
```

then run

```bash
tmux source-file ~/.tmux.conf
```

---

**Run nvim in `tmux` session (when using truecolor colorscheme)**
