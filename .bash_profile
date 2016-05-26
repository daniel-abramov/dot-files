. ~/.bashrc

# Enable OS X color terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

[ -f /etc/bashrc ] && . /etc/bashrc

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

PROMPT_COMMAND='history -a; printf "\[\e[38;5;59m\]%$(($COLUMNS - 4))s\r" "($(date +%m/%d\ %H:%M:%S))"'
PS1='\[\e[0;31m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:'
PS1="$PS1\[\e[m\]\w\[\e[1;31m\] $ \[\e[0m\]"

# Enable gruvbox theme
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source /usr/local/etc/bash_completion.d/ag.bashcomp.sh

fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

export FZF_DEFAULT_OPTS="--extended --cycle"

# fshow - git commit browser (enter for show, ctrl-d for diff, ` toggles sort)
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}
