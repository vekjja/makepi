# ZSH
# Add SSH Agent
#eval $(ssh-agent)

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"
# ZSH_THEME="frisk"
# ZSH_THEME="jispwoso"
# ZSH_THEME="xiong-chiamiov"
# ZSH_THEME="tjkirch"
# ZSH_THEME="pure"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Install Docker Complete Plugin
# mkdir -p ~/.oh-my-zsh/plugins/docker/
# curl -fLo ~/.oh-my-zsh/plugins/docker/_docker https://raw.github.com/felixr/docker-zsh-completion/master/_docker
# And then in your ~/.zshrc file, add docker to the plugins list. Then run exec zsh to restart zsh.
# plugins=(docker)

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.history/zsh_history
# ZSH Globals
export UPDATE_ZSH_DAYS=7 # Update every week
# zsh configuration
COMPLETION_WAITING_DOTS="true" # Waiting dots
HIST_STAMPS="mm.dd.yyyy"       # history timestamp formatting
# DISABLE_CORRECTION="true"             # Disable command autocorrection
# CASE_SENSITIVE="true"                 # Case sensitive completion
# DISABLE_UNTRACKED_FILES_DIRTY="true"  # Don't show untracked files
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
setopt autocd
bindkey -e

#### PATH ####
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:~/.local/bin"

## Python
export PATH=~/Library/Python/2.7/bin:$PATH
export PATH=~/Library/Python/3.6/bin:$PATH

#### Oh My ZSH ####
source $ZSH/oh-my-zsh.sh

## Go
# export GO111MODULE=off
export GOPATH="${HOME}/.go"
export GOBIN=$GOPATH/bin
export PATH="$PATH:${GOBIN}"

# Terminal Colors
export PURP='\033[0;35m'
export BLU='\033[0;34m'
export YEL='\033[0;33m'
export RED='\033[0;31m'
export GRN='\033[0;92m'
export WHT='\033[0;37m'
export NC='\033[0m' # No Color

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

##### System ####
alias ..="cd .."
alias vim="nvim"
alias ls="ls -G"
alias t="tree"
alias l="tree -L 1"
alias cls="clear"
alias la="ls -lha --color=auto"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias listening="lsof -nP +c 15 | grep LISTEN"

#### Git ####
alias g="git"
alias gp="git push"
alias gs="git status"
alias gb="git branch"
alias gpll="git pull"
alias gc="git commit"
alias gco="git checkout"
alias gpm="git add .;git commit;git push"
alias gpn="git add .;git commit;git push --no-verify"
#git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
function gprune() {
  git remote prune origin
  git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D
}
function gpa() {
  git add .
  git commit -am ${1}
  git push
}

#### Quick Dial ####
alias please="sudo"
alias hack_hosts="sudo vim /etc/hosts"
alias temp="/opt/vc/bin/vcgencmd measure_temp"

#### Autojump ####
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
if [ $commands[autojump] ]; then                             # check if autojump is installed
  if [ -f $HOME/.autojump/etc/profile.d/autojump.zsh ]; then # manual user-local installation
    . $HOME/.autojump/etc/profile.d/autojump.zsh
  elif [ -f $HOME/.autojump/share/autojump/autojump.zsh ]; then # another manual user-local installation
    . $HOME/.autojump/share/autojump/autojump.zsh
  elif [ -f $HOME/.nix-profile/etc/profile.d/autojump.zsh ]; then # nix installation
    . $HOME/.nix-profile/etc/profile.d/autojump.zsh
  elif [ -f /usr/share/autojump/autojump.zsh ]; then # debian and ubuntu package
    . /usr/share/autojump/autojump.zsh
  elif [ -f /etc/profile.d/autojump.zsh ]; then # manual installation
    . /etc/profile.d/autojump.zsh
  elif [ -f /etc/profile.d/autojump.sh ]; then # gentoo installation
    . /etc/profile.d/autojump.sh
  elif [ -f /usr/local/share/autojump/autojump.zsh ]; then # freebsd installation
    . /usr/local/share/autojump/autojump.zsh
  elif [ -f /opt/local/etc/profile.d/autojump.zsh ]; then # mac os x with ports
    . /opt/local/etc/profile.d/autojump.zsh
  elif [ $commands[brew] -a -f $(brew --prefix)/etc/autojump.zsh ]; then # mac os x with brew
    . $(brew --prefix)/etc/autojump.zsh
  fi
fi
