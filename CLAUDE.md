# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS: Neovim (LazyVim), WezTerm, and Zsh configurations.

## Structure

- `nvim/` - Neovim config using LazyVim; plugins in `lua/plugings/` (note the typo)
- `wezterm/` - WezTerm terminal config
- `zsh/` - Zsh configuration with aliases and tool integrations

## Commands

Format Neovim Lua files:
```bash
stylua nvim/
```

## Key Configuration Details

- **Neovim**: LazyVim-based, Tokyo Night Storm theme, 4-space indentation
- **Lua style**: 2-space indent, 120 column width (see `nvim/stylua.toml`)
- **Copilot keymaps**: `<C-l>` accept, `<C-j>` next, `<C-k>` prev, `<C-h>` dismiss
