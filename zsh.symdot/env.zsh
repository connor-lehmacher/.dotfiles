# Editor variables
export EDITOR='vim'
export VISUAL='vim'

# System name
[ $(uname) = "Darwin" ] && export DARWIN=1
[ $(uname) = "Linux" ] && export LINUX=1

# Path configuration
# Private bin
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# Homebrew
if [ $(brew -v) ]; then
    BREW_PREFIX=$(brew --prefix)

    PATH="$BREW_PREFIX/bin:$PATH"
    
    # Deal with coreutils if installed
    [ -d "$BREW_PREFIX/opt/coreutils/libexec/gnubin" ]
        && PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin"
    [ -d "$BREW_PREFIX/opt/coreutils/libexec/gnuman" ]
        && MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnuman"

    # If homebrew is installed on linux we also need to update build variables
    if [ "$LINUX" ]; then
        export CPATH="$BREW_PREFIX/include:$CPATH"
        export LD_LIBRARY_PATH="$BREW_PREFIX/lib:$LD_LIBRARY_PATH"
    fi
fi

[ -f "$HOME/bin/consolidate-path" ] && PATH="$(consolidate-path "$PATH")"

export PATH

# OCaml/OPAM configuration
if [ -f "$HOME/.opam/opam-init/init.sh" ]; then
    source "$HOME/.opam/opam-init/init.sh" > /dev/null 2>&1 || true
    eval $(opam config env)
fi
