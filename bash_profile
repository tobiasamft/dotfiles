#export PATH=$PATH:~/bin/
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# customize prompt
export PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad

GIT_PROMPT_ONLY_IN_REPO=0
source ~/.bash-git-prompt/gitprompt.sh

# osx stuff
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# gpg on mac
git config --unset gpg.program
export GPG_TTY=$(tty)

# brew auto completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
fi

# asdf stuff
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
export ASDFROOT=$HOME/.asdf
export ASDFINSTALLS=$HOME/.asdf/installs

# go stuff
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
#export GOROOT=/usr/local/opt/go/libexec
GOV=$(asdf current golang | sed 's/[[:blank:]]*(set by .*)//g')
export GOROOT=$ASDFINSTALLS/golang/$GOV/go/
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# qt stuff
export PATH="/usr/local/opt/qt/bin:$PATH"
export QT_DIR="/usr/local/opt/qt/bin"

# bash aliases
alias lein='~/bin/lein.sh'

alias ga="git add"
alias gb="git branch"
alias gbd="git branch -D"
alias gc="git commit -S"
alias gd="git diff"
alias gco="git checkout"
alias gp="git push"
alias gr="git reset"
alias grh="git reset --hard"
alias gs="git status"

clown () {
    git clone git@github.com:ivx/"$1".git
}

alias dc="docker-compose"

alias be="bundle exec"
alias ber="bundle exec rake"

alias elint="mix format && mix credo --strict"
alias rlint="bundle exec rubocop -a"
alias golint="go fmt ./..."

alias pipenv="python3 -m pipenv"
alias pyrun="pipenv run python"
alias py="pipenv shell"
