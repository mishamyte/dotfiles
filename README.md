# dotfiles

My development configurations, managed with [chezmoi](https://www.chezmoi.io/).

## Tech Stack

- **Shell**: Git Bash + [oh-my-posh](https://ohmyposh.dev/) (custom synthwave prompt)
- **Terminal**: Windows Terminal with synthwave theme + custom backgrounds
- **Editor**: VS Code (Default Dark+, JetBrains Mono)
- **Tools**: Docker, Git, GitHub CLI, kubectl
- **Font**: JetBrains Mono

## Setup

```bash
# Install chezmoi
scoop install chezmoi
# or: winget install twpayne.chezmoi

# Initialize and apply
chezmoi init --apply mishamyte
```

You'll be prompted for:
- Git email address
- Raspberry Pi hostname
- MMX server IP

## What's Managed

| Config | Templated | Notes |
|--------|-----------|-------|
| `.bashrc` | No | Git, Docker, kubectl aliases |
| `.bash_profile` | No | oh-my-posh init |
| `.minttyrc` | No | JetBrains Mono font |
| `oh-my-posh-theme.json` | No | Synthwave prompt theme |
| `.gitconfig` | Yes | Email prompted at setup |
| `.config/git/ignore` | No | Global gitignore |
| `.ssh/config` | Yes | Server IPs prompted at setup |
| Windows Terminal settings | No | Synthwave color scheme |
| Windows Terminal backgrounds | No | 5 images, installed via script |
| VS Code settings | No | Editor preferences |
| GitHub CLI config | No | Protocol + aliases |

## Daily Usage

```bash
chezmoi diff          # See what would change
chezmoi apply         # Apply changes from repo
chezmoi edit ~/.bashrc # Edit a managed file
chezmoi update        # Pull + apply from remote
```
