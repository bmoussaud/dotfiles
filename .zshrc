# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="robbyrussell"


#https://gist.github.com/kevin-smets/8568070#custom-prompt-styles
DEFAULT_USER=$(whoami)



# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
#plugins=(git dirhistory brew dircycle gitfast git-extras jsontools node npm osx repo sudo urltools web-search dirpersist history-substring-search last-working-dir )
#plugins=(git dirhistory dircycle gitfast git-extras jsontools macos repo sudo urltools web-search dirpersist history-substring-search last-working-dir zsh-completions )

#plugins=(git kube-ps1 kubectl history emoji encode64 copypath copyfile dirhistory jsontools gitfast  )
#plugins=(git kube-ps1  kubectl history zsh-syntax-highlighting zsh-autosuggestions)
# install zsh-completion git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
#fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias gvi='mvim -g --remote-tab-silent'
export VISUAL='mvim -f'

export BAT_THEME="ansi-dark"
export BAT_THEME="1337"
export BAT_STYLE="numbers,changes,header"
export BAT_PAGER=""

function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found=true ${i}
  done
}


alias cat='batcat --style header --style snip --style changes --style header'
alias ldk8sctx="source /Users/bmoussaud/Workspace/bmoussaud/tanzutips/context/load-k8s-config.sh"
alias kctx=kubectx
alias kns=kubens
alias kev="kubectl get events --sort-by=.metadata.creationTimestamp "
alias keva="kubectl get events --sort-by=.metadata.creationTimestamp -A"
alias kdebug="kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -- /bin/bash"
function kdecsec() {
	echo "Secret: $*"
	kubectl get secret $*  -o go-template='{{range $k,$v := .data}}{{printf "%s: " $k}}{{if not $v}}{{$v}}{{else}}{{$v | base64decode}}{{end}}{{"\n"}}{{end}}'
}
function kfinalpatch() {
	kubectl patch  $* -p '{"metadata":{"finalizers":[]}}' --type=merge
}




alias kauth="kubectl auth can-i list deployments --as system:serviceaccount:default:default"

alias dockercleanall="docker system prune --all --force --volumes"
alias dockersh='docker run -it --entrypoint sh '



function start-aks-cluster() {
	CLUSTER_NAME=$1
	az aks start --resource-group ${CLUSTER_NAME} --name ${CLUSTER_NAME}
  	kubie ctx ${CLUSTER_NAME}
}

function stop-aks-cluster() {
	CLUSTER_NAME=$1
	az aks stop --resource-group ${CLUSTER_NAME} --name ${CLUSTER_NAME}
}


eval "$(task --completion zsh)"
eval "$(kubectl completion zsh)"
DEFAULT_USER=$USER
# remove username@hostname in prompt as advised at
# https://github.com/ohmyzsh/ohmyzsh/issues/5581#issuecomment-256825141
prompt_context() {}


