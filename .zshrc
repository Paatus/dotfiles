# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.config/scripts:$PATH
export PATH=$HOME/.yarn/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/paatus/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="wedisagree"

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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

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
plugins=(git)

source $ZSH/oh-my-zsh.sh

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
export EDITOR=nvim

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

export NVIM_APPNAME="lazy-nvim-config"
# alias v="TMPDIR=~/.config/nvim/tmp nvim"
# alias nvim="NVIM_APPNAME=lazy-nvim-config nvim"
alias nvim_old="NVIM_APPNAME=nvim nvim"
alias v="NVIM_APPNAME=lazy-nvim-config nvim"
alias pacman="sudo pacman --color=always"
alias dots='/usr/bin/git --git-dir=$HOME/Dev/dotfiles.git/ --work-tree=$HOME'
alias kc="kubectl"
alias kt="kubetail"

kcn() {
    local namespace="$1"

    # Check if the namespace is provided
    if [ -z "$namespace" ]; then
        echo "Error: Namespace is required."
        return 1
    fi

    # Set the current context's namespace using kubectl
    kubectl config set-context --current --namespace="$namespace"
}

# Define auto-completion for the kcn function
_set_kubectl_namespace() {
    local -a namespaces=("flamingo-prod" "flamingo-stag")

    _arguments "1: :($(echo $namespaces))"
}

# Use compdef to associate the auto-completion with the kcn function
compdef _set_kubectl_namespace kcn

dots config status.showUntrackedFiles no

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
PATH=$PATH:$HOME/.npm-global/bin

# fnm
export PATH="/home/paatus/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

maybeLogin () {
    op account get >/dev/null 2&>/dev/null
    hasErr=$?
    if [ $hasErr -eq 1 ]; then
      eval $(op signin --account meltwater.1password.eu)
    fi
}

prodtoken () {
    maybeLogin
    PASSWORD=$(op item get mpgkwa6evvt5rbhubtzyporlp4 --vault ncnyo2whlfs52y37kqsq3a4iky --fields password)
	  curl -s -XPOST "https://live.gaf-identity-provider.meltwater.io/login" -H "Content-Type: application/json" -d '{ "email": "pontus.hjortskog@meltwater.com", "password": "'${PASSWORD}'" }' | jq -r .
}

stagingtoken () {
    maybeLogin
    PASSWORD=$(op item get kqwetq5nyn2lkvr2r4l4owv5bu --vault ncnyo2whlfs52y37kqsq3a4iky --fields password)
	curl -s -XPOST "https://live.staging.gaf-identity-provider.meltwater.io/login" -H "Content-Type: application/json" -d '{ "email": "pontus.hjortskog@meltwater.com", "password": "'${PASSWORD}'" }' | jq -r .
}
