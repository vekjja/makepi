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
plugins=(docker)

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.history/zsh_history
  # ZSH Globals
export UPDATE_ZSH_DAYS=7                # Update every week
  # zsh configuration
COMPLETION_WAITING_DOTS="true"          # Waiting dots
# HIST_STAMPS="mm.dd.yyyy"                # history timestamp formatting
# DISABLE_CORRECTION="true"             # Disable command autocorrection
# CASE_SENSITIVE="true"                 # Case sensitive completion
# DISABLE_UNTRACKED_FILES_DIRTY="true"  # Don't show untracked files
# ZSH_CUSTOM=/path/to/new-custom-folder # Use alternative custom folder
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
setopt autocd
bindkey -e

#### PATH ####
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:~/.local/bin"
  ## PHP 7.2
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"

  ## Go
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

  ## Python
export PATH=~/Library/Python/2.7/bin:$PATH
export PATH=~/Library/Python/3.6/bin:$PATH

  ## Kotlin
export PATH=~/kotlin-native/dist/bin:$PATH

  ## Google Cloud
if [ -f '/Users/kjayne/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kjayne/google-cloud-sdk/path.zsh.inc'; fi


#### Oh My ZSH ####
source $ZSH/oh-my-zsh.sh

# Ruby
#source /Users/kjayne/.rvm/scripts/rvm

# Java
#test -e "/usr/libexec/java_home" && export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

#### Power-Line ####
# if [[ -r /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
#     source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# fi

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
alias la="ls -lha"
alias flush_dns="sudo killall -HUP mDNSResponder"
alias wakeGameBox="wakeonlan -i 10.0.0.255 bc:ae:c5:50:ef:49"
#alias wakeGameTop="wakeonlan -i 10.0.0.255 0C:8B:FD:7E:D4:6B"
alias shutdownlivingroom="ssh -t livingroom sudo shutdown now"
alias showHidden="defaults write com.apple.finder AppleShowAllFiles YES"
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias listening="lsof -nP +c 15 | grep LISTEN"

# K8S
#export KUBECONFIG=$HOME/.kube/config
#export KUBECONFIG=$HOME/.kube/config-training
source <(kubectl completion zsh)

alias k="kubectl"
alias kg="k get"
alias kga="k get all"
alias kps="k get po"
alias kd="k describe"
alias kex="k exec -it"

function configK8s() {

  while getopts 'r:c:n:' flag; do
     case "${flag}" in
       r)
         CLUSTER_REGION="${OPTARG}"
         ;;
       c)
         CLUSTER_NAME="${OPTARG}"
         ;;
       *)
         error "Unexpected Option"; showHelp
         ;;
     esac
  done
  CLUSTER_REGION=${CLUSTER_REGION:?"CLUSTER_REGION must be set"}
  CLUSTER_NAME=${CLUSTER_NAME:?"CLUSTER_NAME must be set"}

  eksctl utils write-kubeconfig \
    --authenticator-role-arn arn:aws:iam::780407293935:role/ClusterAdmin \
    --region ${CLUSTER_REGION} \
    --cluster ${CLUSTER_NAME} \
    --set-kubeconfig-context
}

# Helm
alias h="helm"

# Terraform
alias tf="terraform"

# GCLOUD
function gc-set-project() {

  case "${1:-dev}" in
    dev|stag)
      project=podium-devstage
      ;;
    loadtest)
      project=podium-loadtest
      ;;
    prod)
      project=podium-production
      ;;
    *)
      echo "Invalid Project ${1}"
      exit 1
      ;;
  esac

  gcloud config set project ${project}
  gcloud container clusters get-credentials east1-cluster

}

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
function gprune(){
  git remote prune origin 
  git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D
}
function gpa() {
  git add .
  git commit -am ${1}
  git push
}

#### Vagrant ####
alias vup="vagrant up"
alias vhalt="vagrant halt"
alias vdestroy="vagrant destroy"
alias vssh="vagrant ssh"

#### Docker ###
alias d="docker"
alias dc="docker-compose"
alias dcd="docker-compose down"
alias dcu="docker-compose up"
alias dcs="docker-compose stop"
alias dps="docker ps"
alias di="docker images"
alias d-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias drmfa="docker rm -f $(docker ps -aq)"

function drmi() {
  while getopts 'f' flag; do
    case "${flag}" in
      f) force="-f"
         shift "$((OPTIND-1))"
      ;;
    esac
  done  
  docker rmi ${force} $(docker images | grep "${1:-none}" | awk '{print $3}')
}

function dexec() {
  docker exec -it $(docker ps -aqf "name=${1}") "${@:2}"
}

function dls() {
  docker ps -af "name=$1"
}
  
#### Quick Dial ####
alias hack_hosts="sudo vim /etc/hosts"
alias chrome-socks='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --proxy-server="socks5://127.0.0.1:8080" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"'

function enc() {
  openssl des -in ${1} -out ${1}.enc
}

function dec() {
  openssl des -d -in ${1} -out ${2:-decrypted.txt}
}

function decode()
{
  echo;echo ${1-TXVzdCBQcm92aWRlIEJhc2U2NCBFbmNvZGVkIFN0cmluZwo} | base64 --decode
}

#### AWS ####
# alias admin-ips='aws ec2 describe-instances --filter "Name=tag:Name,Values=admin-ecs" --query "Reservations[*].Instances[].PrivateIpAddress" --output text'

function aws-export(){
  export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials | grep aws_access_key_id | awk '{print $3}')
  export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials | grep aws_secret_access_key | awk '{print $3}')
  export AWS_SESSION_TOKEN=$(cat ~/.aws/credentials | grep aws_session_token | awk '{print $3}')
}

function aws-unset(){
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}


function aws-instance-ips(){
  INSTANCE=${1:-admin-ecs}
  echo "IPs For Instances with Name Tag: ${INSTANCE}"
  aws ec2 describe-instances --filter "Name=tag:Name,Values=${INSTANCE}" --query "Reservations[*].Instances[].PrivateIpAddress" --output text
}

#### Ethereum ####
alias ewallet-clear-data="rm -fr ~/Library/Application\ Support/Ethereum\ Wallet/"
function ewallet() {
  port=${1-8545}
  open -a /Applications/Ethereum\ Wallet.app/Contents/MacOS/Ethereum\ Wallet --args --rpc http://localhost:$port
}

#### SSH ####
function jt() { # Jumo To
  jumphost=jump1
  [[ $1 == http* ]] && remote=$(echo $1 | awk -F "\/" '{print $3}') || remote=$1
  remote=${remote//-/.}
  printf "\n Jumping to: $remote\n"

  if [[ $remote == 10.204.10*  ]]; then
    ssh -t -o StrictHostKeyChecking=no $remote $2
  else
    ssh -t $jumphost ssh -t -o StrictHostKeyChecking=no $remote $2
  fi
}


function tunnel(){
  : ${1:?Must Provide Remote Host and port 0.0.0.0:8080}
 LOCAL_PORT=10000
 JUMP_HOST=172.24.4.68
 local OPTIND=1

 while getopts ':l:jr' flag; do
   case "${flag}" in
     l)
       LOCAL_PORT="${OPTARG}"
       shift "$((OPTIND-1))"
       ;;
     j)
       printf "\nUsing Jump Host $JUMP_HOST\n"
       USE_JUMPT_HOST=true;
       shift "$((OPTIND-1))"
       ;;
     r)
       LOCAL_PORT="$((1000 + RANDOM % 10000))"
       shift "$((OPTIND-1))"
       ;;
     *) error "Unexpected option ${flag}" ;;
   esac
 done 

 shift $(($OPTIND - 1))
 REMOTE_HOST=${1%%:*}
 REMOTE_PORT=${1##*:} 


  printf "\nCreating Tunnel: http://localhost:$LOCAL_PORT\n\n \
  Local Port: $LOCAL_PORT\n \
  Remote Host: $REMOTE_HOST\n \
  Remote Port: $REMOTE_PORT\n\n"
 
  [[ $USE_JUMP_HOST ]] && echo "Using Jump Host"\
    ssh -o StrictHostKeyChecking=no -T -L "$LOCAL_PORT":localhost:"$LOCAL_PORT" $JUMP_HOST ssh -o StrictHostKeyChecking=no -T -L "$LOCAL_PORT":localhost:"$REMOTE_PORT" $REMOTE_HOST \
  || \
    ssh -o StrictHostKeyChecking=no -T -L "$LOCAL_PORT":localhost:"$REMOTE_PORT" $REMOTE_HOST
}

function ssh-wait(){
  # Vars
  IP=$1
  index=1
  sleepSeconds=10
  maxConnectionAttempts=30
  
  # Wait for the box to become available via ssh
  echo "Attemting to SSH to $IP"
    while (( $index <= $maxConnectionAttempts ))
    do
      ssh -T -o ConnectTimeout=2 -o StrictHostKeyChecking=no $IP date
      case $? in
        (0) echo "👌  SSH Success"; break ;;
        (*) printf "Attempt ${index} of ${maxConnectionAttempts}\n $IP not ready yet, waiting ${sleepSeconds} seconds...💤" ;;
      esac
      sleep $sleepSeconds
      ((index+=1))
    done
  
  if [ $index -ge $maxConnectionAttempts ]; then
    echo "⛔️  Error: Max Connection Attemps, $IP is unreachable ";
  fi
}

function ssh-init(){
ssh -t $1 '
sudo apt install htop vim -y
cat << EOF > ~/.bash_aliases
# Source global definitions
#if [ -f /etc/bashrc ]; then
#        . /etc/bashrc
#fi

# User specific aliases and functions
alias la="ls -lah"
alias cls="clear"
alias d="docker"
alias ..="cd .."
alias pubip="echo;curl -s http://whatismyip.akamai.com/;echo"

aws-metadata(){
  curl http://169.254.169.254/latest/meta-data/\${1}
}
'
ssh $1
}


#### RANDOM ####


#### Hooks ####
# AWS CLI Completer
test -e "$(which aws_zsh_completer.sh)" && source $(which aws_zsh_completer.sh)

#### iTerm ####
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#### Autojump ####
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
if [ $commands[autojump] ]; then # check if autojump is installed
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
  elif [ $commands[brew] -a -f `brew --prefix`/etc/autojump.zsh ]; then # mac os x with brew
    . `brew --prefix`/etc/autojump.zsh
  fi
fi

# Google Cloud Shell Completion
if [ -f '/Users/kjayne/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kjayne/google-cloud-sdk/completion.zsh.inc'; fi

# Don't Share History per session
unsetopt share_history
