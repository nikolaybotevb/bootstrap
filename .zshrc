# Options

setopt alwaystoend
setopt autopushd
setopt completeinword
setopt extendedhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histverify
setopt interactivecomments
setopt longlistjobs
setopt promptsubst
setopt pushdignoredups
setopt pushdminus
setopt sharehistory


# Autocomplete
autoload -U compinit && compinit


# Prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure


# Aliases and Functions

alias ls='ls -hFG'
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -la'

alias s='ssh -X'
alias g='git'
alias gw='./gradlew'

function gpo {
  git push 2>&1 | awk '{ print } $1 == "remote:" && $2 ~ /^https:/ { system("open " $2) }'
}

function gpc {
  git checkout master
  git pull 2>&1 | awk '{ print } $2 == "[deleted]" { sub(/origin\//, "", $5); system("git branch -D " $5) }'
}

function gitlinesx {
  local ex="$1"
  shift
  git log --pretty=format:"%h,%an,%cd,%f" --date=iso-strict --numstat "$@" | grep -Ev "$ex" | awk '
    /^$/ { print ll "," ac "," rc; ll=""; next }
    ll == "" { ll = $0; ac = 0; rc = 0; next }
    ll != "" { ac = ac + $1; rc = rc + $2; }
    END { print ll "," ac "," rc }'
}

function gitlines {
  git log --pretty=format:"%h,%an,%cd,%f" --date=iso-strict --numstat "$@" | awk '
    /^$/ { print ll "," ac "," rc; ll=""; next }
    ll == "" { ll = $0; ac = 0; rc = 0; next }
    ll != "" { ac = ac + $1; rc = rc + $2; }
    END { print ll "," ac "," rc }'
}


# External Scripts
export PATH="$PATH:$HOME/.bootstrap/bin"


# Sudoless Cocoapods
# See https://guides.cocoapods.org/using/getting-started.html#sudo-less-installation
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
