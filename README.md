# dotfiles

My development configurations, managed with [chezmoi](https://www.chezmoi.io/).

## Tech Stack

- **Shell**: Git Bash + [oh-my-posh](https://ohmyposh.dev/) (custom synthwave prompt)
- **Terminal**: Windows Terminal with synthwave theme + custom backgrounds
- **Editor**: VS Code (Default Dark+, JetBrains Mono)
- **Tools**: Docker, Git, GitHub CLI, kubectl
- **Font**: JetBrainsMono Nerd Font

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
| `.bashrc` | No | Git, Docker, kubectl, WAU aliases |
| `.bash_profile` | No | oh-my-posh init |
| `.minttyrc` | No | JetBrainsMono NFM, size 12 |
| `oh-my-posh-theme.json` | No | Synthwave prompt theme |
| `.gitconfig` | Yes | Email prompted at setup, `[include]` for local overrides |
| `.config/git/ignore` | No | Global gitignore (OS files, IDE, Claude Code) |
| `.ssh/config` | Yes | Server IPs prompted at setup |
| Windows Terminal settings | No | Synthwave color scheme, JetBrainsMono NF for Git Bash |
| Windows Terminal backgrounds | No | 5 images, installed via script |
| VS Code settings | No | Editor preferences |
| GitHub CLI config | No | Protocol + aliases |

### Run Scripts

| Script | Trigger | Notes |
|--------|---------|-------|
| `install-completions.sh` | Once | Downloads git + kubectl bash completions |
| `install-wt-backgrounds.sh` | Once | Copies WT background images to RoamingState |
| `sync-wau.sh` | On change | Syncs WAU excluded apps + mods to Program Files (needs admin) |

### Per-Machine Overrides

`.gitconfig` includes `~/.gitconfig.local` (not managed by chezmoi) for machine-specific settings like `includeIf` rules.

## Daily Usage

```bash
chezmoi diff          # See what would change
chezmoi apply         # Apply changes from repo
chezmoi edit ~/.bashrc # Edit a managed file
chezmoi re-add        # Pull local edits back into source
chezmoi update        # Pull + apply from remote
```
