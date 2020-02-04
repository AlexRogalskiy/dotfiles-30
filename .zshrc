# Things upon which things depend
export WORKON_HOME=~/.virtualenvs
export EDITOR=`which vim`
export BROWSER=`which firefox-developer-edition`


# Shell customization
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle "MichaelAquilina/zsh-you-should-use"
antigen bundle virtualenvwrapper
antigen bundle command-not-found
antigen theme agnoster/agnoster-zsh-theme agnoster
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# SDK homes, etc
export NODE_REPL_HISTORY=$HOME/.node_history
export ANDROID_HOME=${HOME}/.android/Sdk
export DOTNET_ROOT=/opt/dotnet/
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export GOPATH=$HOME/.go
export PATH=$HOME/.bin:$PATH


# Load aliases
[ -s ~/.aliases ] && source ~/.aliases

# Load secrets
[ -s ~/.secrets ] && source ~/.secrets

# Save lots of history
HISTSIZE=10000               
SAVEHIST=100000      

# Optimal settings for history, expansion, annoyances, etc
setopt appendhistory    
setopt incappendhistory
setopt sharehistory      
setopt extendedglob          
setopt nocaseglob            
setopt rcexpandparam         
setopt nocheckjobs           
setopt numericglobsort       
setopt nobeep                
setopt appendhistory         
setopt histignorealldups     
setopt autocd
zstyle ':completion:*' rehash true
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# Local mailservers are unlikely to be prod, don't annoy
unset MAILCHECK


# Unix timestamp to readable date
function ttd {
	date -d @$1
}

# Temporary scratch dir
function tempe () {
  cd "$(mktemp -d)"
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
  fi
}

# Upload from CLI
function transfer() { curl --progress-bar --upload-file "$1" https://transfer.sh/$1 && printf "\n"}

# Get me a gitignore
gi() {
	curl -s "https://www.gitignore.io/api/$*"
}

function goto() { cd $(dirname $1) }

# Java version manager
[ -s ~/.jabba/jabba.sh ] && source ~/.jabba/jabba.sh


# Don't scale qt please
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5
export QT_SCALE_FACTOR=1
export QT_AUTO

# Set locale if unset
if [[ $LANG = '' ]]; then
	export LANG=en_US.UTF-8
fi

# Fix jetbrains history bug
unset __INTELLIJ_COMMAND_HISTFILE__

# Fast node manager
export PATH=/home/joshua/.fnm:$PATH
eval "`fnm env --multi`"


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# fzf default ignore generated dirs
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}" 2> /dev/null'

# initialize thefuck to help with common mistakes
eval $(thefuck --alias)

# web3j cli
[ -s "$HOME/.web3j/source.sh" ] && source "$HOME/.web3j/source.sh"

# solidity version manager
[ -s "$HOME/.svm/svm.sh" ] && source "$HOME/.svm/svm.sh"
