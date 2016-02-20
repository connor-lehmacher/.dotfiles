# Configure aliases and functions

# grep
alias grep='grep --color=auto'

# ls
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias l.='ls -d .*'
alias ls='ls --color=auto'

# other
alias dspurge='find . -name .DS_Store -delete'
alias bc='bc -l'

if [ -f "/usr/libexec/java_home" ]; then
    # Sets the version to the specified version
    # Kind of actually just a glorified alias to /usr/libexed/java_home
    # use -v <version> to set the version to the specified version
    function jhome () {
        export JAVA_HOME=`/usr/libexec/java_home $@`
        echo "JAVA_HOME:" $JAVA_HOME
        echo "java -version:"
        java -version
    }
fi

# Sets up an eclipse workspace
# First the workspace must exist then run this command with the path
# to the workspace as the argument
# The settings folder of the workspace will be deleted and symlinked to
# The template workspace at ~/.templates/eclipse
function eclset () {
    present_dir=`pwd`
    cd  $1/.metadata/.plugins/org.eclipse.core.runtime
    rm -rf .settings
    ln -s ~/.templates/eclipse/.metadata/.plugins/org.eclipse.core.runtime/.settings .settings
    cd $present_dir
}

# Swaps the location of two files
function swap () {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

if [ -f "$HOME/.aliases.local" ]; then
    source "$HOME/.aliases.local"
fi
