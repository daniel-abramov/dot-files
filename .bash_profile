# Enable OS X color terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Change default terminal prompt
PS1='\[\e[0;31m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
