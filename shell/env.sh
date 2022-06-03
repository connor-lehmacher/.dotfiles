#!/bin/bash

# Editor variables
if nvim --version >/dev/null 2>&1; then
    EDITOR='nvim'
    VISUAL='nvim'
elif vim --version >/dev/null 2>&1; then
    EDITOR='vim'
    VISUAL='vim'
else
    EDITOR='vi'
    VISUAL='vi'
fi
export EDITOR
export VISUAL

# System name
[ "$(uname)" = "Darwin" ] && export DARWIN=1
[ "$(uname)" = "Linux" ] && export LINUX=1

# Path configuration
cond_path_add () {
    [ -n "$1" ] || (echo "cond_path_add requires 1 argument"; exit 1)
    [ -d "$1" ] && PATH="$1:$PATH"
}

# Private bin
cond_path_add "$HOME/bin"

# Dotfiles bin
cond_path_add "$DOTFILES/bin"

# Local bin
cond_path_add "$HOME/.local/bin"

# Rust
if [ -d "$HOME/.cargo" ]; then
    # Cargo bin
    PATH="$HOME/.cargo/bin:$PATH"
    # PATH="$HOME/.cargo/bin:$PATH"
    # Rust src folder
    # toolchain="$(rustup toolchain list | awk '/\(default\)/{print $1}')"
    # RUST_HOME="$HOME/.rustup/toolchains/$toolchain"
    # PATH="$RUST_HOME/bin:$PATH"
    # export RUST_SRC_PATH="$HOME/.rustup/toolchains/$toolchain/lib/rustlib/src/rust/src"
fi

# Go
cond_path_add "/usr/local/go/bin"

#Ruby
source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.2

# set up tex live
if [ ! -z "$LINUX" ]; then
  cond_path_add "/usr/local/texlive/2019/bin/x86_64-linux"
  MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH; export MANPATH
  INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH; export INFOPATH
elif [ ! -z "$DARWIN" ]; then
  cond_path_add "/Library/TeX/texbin"
  MANPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Man:$MANPATH; export MANPATH
  INFOPATH=/Library/TeX/Distributions/.DefaultTeX/Contents/Info:$INFOPATH; export INFOPATH
fi


# Homebrew
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# OPAM configuration
. /Users/devin/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

if [ -d "$HOME/Library/Haskell/" ]; then
    PATH="$PATH:$HOME/Library/Haskell/bin"
    MANPATH="$MANPATH:$HOME/Library/Haskell/share/man"
fi
cond_path_add "$HOME/.ghcup/bin" # haskell binaries from ghcup

# Add fzf to path
if [ -d "$HOME/.fzf" ]; then
    PATH="$PATH:$HOME/.fzf/bin"
    MANPATH="$MANPATH:$HOME/.fzf/man"
fi

# Add python local --user bins to the path
if [ -d "$HOME"/Library/Python ]; then
    for p in "$HOME"/Library/Python/* ; do
        PATH="$p/bin:$PATH"
    done
fi

# Windows (WSL) things
[ -d /mnt/c/Windows ] || export WINDIR=/mnt/c/Windows
cond_path_add "/mnt/c/ProgramData/chocolatey/bin" # chocolatey installations
cond_path_add "/mnt/c/Windows/System32" # cmd.exe
cond_path_add "/mnt/c/Windows/System32/WindowsPowerShell/v1.0" # powershell.exe

# Remove inconsistent path entries and export
if [ -f "$DOTFILES/bin/consolidate-path" ]; then
    PATH="$(consolidate-path "$PATH")"
    MANPATH="$(consolidate-path "$MANPATH")"
fi
export PATH
export MANPATH
