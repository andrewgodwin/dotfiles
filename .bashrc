# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=20000
HISTFILESIZE=20000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    if [ `uname` == "Darwin" ]; then
        export CLICOLOR=1
    else
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
    fi
fi

# Aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias nano='nano -w'
alias agi='sudo apt install'
alias agu='sudo apt update'
alias agdu='sudo apt dist-upgrade'
alias acs='apt-cache search'
alias agr='sudo apt remove'
alias nano='nano -w'
alias rmsvn='find . -name .svn -print0 | xargs -0 rm -rf'
alias rmpyc='find . -name "*.pyc" -print0 | xargs -0 rm -rf'
alias rmpycache='find . -name "__pycache__" -print0 | xargs -0 rm -rf'
alias rmswp='find . -name "*.swp" -print0 | xargs -0 rm -rf'
alias rmsync='find . -name "*.sync-conflict-*" -print0 | xargs -0 rm -rf'
alias psgrep='ps -AF | grep'
alias pullall='find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pul \;'
alias kc='kubectl'
alias airdir='cd ~/Programs/airflow; pyenv shell airflow'
alias tkdir='cd ~/Programs/takahe; pyenv shell takahe'
alias aerdir='cd ~/Programs/aeracode; pyenv shell aeracode'
alias venusaur="ssh -t root@venusaur.internal.aeracode.org"
alias charizard="ssh -t andrew@192.168.2.6 -- screen -d -R"

# Shares current dir on port 8000
alias sharedir='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'

# I hate losing my place.
alias cd='pushd > /dev/null'
alias uncd='popd > /dev/null'

# Picks a random colour based on the hostname.
function color_from_hostname {
    if [ "$USER" == "root" ]; then
        echo 1
        return
    fi
        hash=`(echo $USER; hostname) | md5sum | awk '{print $1}'`
        case ${hash#${hash%?}} in
        "0") c="5" ;; # purple
        "1") c="6" ;; # cyan
        "2") c="2" ;; # green
        "3") c="2" ;; # green
        "4") c="4" ;; # blue
        "5") c="4" ;; # blue
        "6") c="6" ;; # cyan
        "7") c="6" ;; # cyan
        "8") c="5" ;; # purple
        "9") c="5" ;; # purple
        "a") c="4" ;; # blue
        "b") c="2" ;; # green
        "c") c="5" ;; # purple
        "d") c="5" ;; # purple
        "e") c="4" ;; # blue
        "f") c="6" ;; # cyan
        esac
        echo $c
}

# VCS functions
parse_git_branch () {
    if [ -d ".git" -o -d "../.git" -o -d "../../.git" -o -d "../../../.git" -o -d "../../../../.git" ]; then
            git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#git:\1 #'
    fi
}
virtualenvname () {
    if [ `echo $VIRTUAL_ENV` ]; then
        echo -n "ve:`basename $VIRTUAL_ENV` "
    fi
}
command_exists () {
    type "$1" &> /dev/null ;
}

# Customised prompt; shows git/venv status too
PROMPT_DIRTRIM=2
title () {
    PS1="\[\e]0;$1\a\]"'\[\e[4`color_from_hostname`m\]\[\e[1;37m\] \h \[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[42m\] `parse_git_branch``virtualenvname`> \[\e[0m\] '
}
title "\w"

# Set editor based on if we're in a VS Code shell or not
if [ -z $VSCODE_IPC_HOOK_CLI ]; then
    export EDITOR=vim
else
    export EDITOR="code --wait"
fi

# Completion
if [ -e /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Ensure that we have an ssh config with AddKeysToAgent set to true
if [ -e ~/.ssh/config ]; then
    if [ ! -f ~/.ssh/config ] || ! cat ~/.ssh/config | grep AddKeysToAgent | grep yes > /dev/null; then
        echo "AddKeysToAgent  yes" >> ~/.ssh/config
    fi
fi

# If keychain is available, load it as a session
if [ -e /usr/bin/keychain ]; then
    /usr/bin/keychain -q --nogui $HOME/.ssh/id_ecdsa
    source $HOME/.keychain/$HOSTNAME-sh
fi

# Python
export PYENV_ROOT="$HOME/.pyenv"
VIRTUAL_ENV_DISABLE_PROMPT=True
if [ -e "$PYENV_ROOT/bin/pyenv" ]; then
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Go
export GOPATH=~/Programs/go

# PostgreSQL settings
export PGUSER=postgres
