#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [[ -z "$__INTELLIJ_COMMAND_HISTFILE__" ]]; then
#	      exec tmux
#fi
#zmodload zsh/zprof
export ZSH_DISABLE_COMPFIX=true


# Things upon which things depend
export WORKON_HOME=~/.virtualenvs
export EDITOR="vim"
export PAGER="less"
export BROWSER=`which firefox-developer-edition`


# Shell customization
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
ZSH_THEME="agnoster"
setopt promptsubst
source ~/.zsh_plugins.sh

# Manual SDK homes
if [[ -d ~/.android ]]
then
	export ANDROID_HOME=${HOME}/.android/
	export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
fi

[ -d ~/.bin ] && export PATH="$HOME/.bin:$PATH"
[ -d ~/.bin/jetbrains ] && export PATH="$PATH:$HOME/.bin/jetbrains"
[ -d ~/go ] && export GOPATH="$HOME/go"
[ -d /opt/dotnet ] && export DOTNET_ROOT="/opt/dotnet/"


# Load aliases
[ -s ~/dotfiles/.aliases ] && source ~/dotfiles/.aliases

# Load secrets
[ -s ~/dotfiles/.secrets ] && source ~/dotfiles/.secrets

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
  cd "$(mktemp -d /tmp/tmp.$(shuf -n 1 ~/dotfiles/wordlist).XXXX)"
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
  fi
}

# Upload from CLI
function transfer() { curl --progress-bar --upload-file "$1" https://transfer.sh/$1 && printf "\n" }

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
if [[ -d ~/.fnm ]]
then
	export PATH="$HOME/.fnm:$PATH"
	eval "`fnm env --multi`"
	export NODE_REPL_HISTORY="$HOME/.node_history"
fi

#Initialize Java
alias java="unalias java &>/dev/null ; unalias jabba &>/dev/null ; source ~/.jabba/jabba.sh ; java"
alias jabba="unalias java &>/dev/null ; unalias jabba &>/dev/null ; source ~/.jabba/jabba.sh ; jabba"

# Initialize Web3j
[ -s ~/.web3j/source.sh ] && source ~/.web3j/source.sh

# Initialize Solidity
alias solc="unalias svm &>/dev/null ; unalias solc &>/dev/null ; source ~/.svm/svm.sh ; solc"
alias svm="unalias svm &>/dev/null ; unalias solc &>/dev/null ; source ~/.svm/svm.sh ; svm"

# Initialize thefuck to help with common mistakes
#eval $(thefuck --alias)

# ensure that on gnome terminals open to the same location as their parent
[ -z "GNOME_TERMINAL_SERVICE" ] || source "/etc/profile.d/vte.sh"
#zprof
