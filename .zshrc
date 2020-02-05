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



# Manual SDK homes
if [[ -d "$HOME/.android" ]]
then
	export ANDROID_HOME=${HOME}/.android/Sdk
	export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
fi

[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.bin/jetbrains" ] && export PATH="$PATH:$HOME/.bin/jetbrains"
[ -d "$HOME/.go" ] && export GOPATH="$HOME/.go"
[ -d "/opt/dotnet" ] && export DOTNET_ROOT=/opt/dotnet/


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


# Don't scale qt please
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5
export QT_SCALE_FACTOR=1
export QT_AUTO

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

# Set locale if unset
if [[ $LANG = '' ]]; then
	export LANG=en_GB.UTF-8
fi

# Fix jetbrains history bug
unset __INTELLIJ_COMMAND_HISTFILE__





# Initialize nodeJS
if [[ -d "~/.fnm" ]]
then
	export PATH="$HOME/.fnm:$PATH"
	eval "`fnm env --multi`"
	export NODE_REPL_HISTORY="$HOME/.node_history"
fi

# Initialize Java
[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

# Initialize Web3j
[ -s "$HOME/.web3j/source.sh" ] && source "$HOME/.web3j/source.sh"

# Initialize Solidity
[ -s "$HOME/.svm/svm.sh" ] && source "$HOME/.svm/svm.sh"

# Initialize thefuck to help with common mistakes
eval $(thefuck --alias)

# ensure that on gnome terminals open to the same location as their parent
[ -z "GNOME_TERMINAL_SERVICE" ] || source "/etc/profile.d/vte.sh"
