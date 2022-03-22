# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/tobias.amft/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
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
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# install plugins
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration
# osx stuff
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# gpg on mac
#git config --unset gpg.program
#export GPG_TTY=$(tty)

# brew auto completion
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
   #. $(brew --prefix)/etc/bash_completion
#fi

export KOPS_STATE_STORE="s3://kops-kubernetes-state"

# bash completion
#[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# cloud-ops stuff
aws-login () {
  aws-session.sh $1
}

ecr-login() {
  aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 276018124710.dkr.ecr.eu-west-1.amazonaws.com
}

ops-login() {
  aws-session.sh $1
  kops-session.sh
}

# enable kubectl autocompletion
# source <(kubectl completion zsh)

# asdf stuff
#. $HOME/.asdf/asdf.sh
#. $HOME/.asdf/completions/asdf.bash
#export ASDFROOT=$HOME/.asdf
#export ASDFINSTALLS=$HOME/.asdf/installs
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# go stuff
GOV=$(asdf current golang | sed 's/golang[[:blank:]]*//g' | sed 's/[[:blank:]]*\/Users.*//g')
export GOROOT=~/.asdf/installs/golang/$GOV/go

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export HELM_DIFF_COLOR=true


# bash aliases
alias macs='emacs -nw'
#alias smacs='emacs &'
alias lein='~/bin/lein.sh'

# docker aliases
alias dostop="docker container stop $1 && docker container rm -v $1"
alias doclean="docker rm -f $(docker ps -a -q) && docker rmi $(docker images -f "dangling=true" -q) --force"
alias doprune="docker system prune -a"
alias dc="docker-compose"

alias be="bundle exec"
alias ber="bundle exec rake"

alias elint="mix format && mix credo --strict"
alias rlint="bundle exec rubocop -a"
alias golint="go fmt ./..."

alias rbfy="rbprettier --write '**/*.rb'"

alias gr="git reset"
alias grh="git reset --hard"

clown () {
    git clone git@github.com:ivx/"$1".git
    cd "$1"
}

invision () {
  cd ~/invision/$1
}

# cloud-ops aliases
alias lds="linkerd --context staging.k8s.ivx.cloud"
alias ldp="linkerd --context production.k8s.ivx.cloud"

alias hfs="helmfile --kube-context staging.k8s.ivx.cloud -e staging"
alias hfp="helmfile --kube-context production.k8s.ivx.cloud -e production"
alias hfi="helmfile --kube-context infra.k8s.ivx.cloud -e infra"

alias ks="kubectl --context staging.k8s.ivx.cloud"
alias ksm="kubectl --context staging.k8s.ivx.cloud -n monitoring"
alias kso="kubectl --context staging.k8s.ivx.cloud -n oauth"
alias ksi="kubectl --context staging.k8s.ivx.cloud -n ingress-nginx"
alias ksl="kubectl --context staging.k8s.ivx.cloud -n linkerd"
alias kslv="kubectl --context staging.k8s.ivx.cloud -n linkerd-viz"

alias kp="kubectl --context production.k8s.ivx.cloud"
alias kpm="kubectl --context production.k8s.ivx.cloud -n monitoring"
alias kpo="kubectl --context production.k8s.ivx.cloud -n oauth"
alias kpi="kubectl --context production.k8s.ivx.cloud -n ingress-nginx"
alias kpl="kubectl --context production.k8s.ivx.cloud -n linkerd"
alias kplv="kubectl --context production.k8s.ivx.cloud -n linkerd-viz"

alias ki="kubectl --context infra.k8s.ivx.cloud"
alias kim="kubectl --context infra.k8s.ivx.cloud -n monitoring"
alias kin="kubectl --context infra.k8s.ivx.cloud -n nginx-ingress"
alias kio="kubectl --context infra.k8s.ivx.cloud -n oauth"

alias kuc="kubectl config use-context"

alias tf="terraform"
alias tfplan="terraform plan -out .plan"
alias tfapply="terraform apply .plan && rm .plan"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
