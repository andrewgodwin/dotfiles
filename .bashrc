# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source system bashrc if it exists
[ -f /etc/bashrc ] && source /etc/bashrc

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
alias hydrae="ssh -t root@hydrae.aeracode.org -- screen -d -R"
alias novae="ssh -t novae.aeracode.org -- screen -d -R"
alias charmeleon="ssh -t andrew@charmeleon.internal.aeracode.org -- 'tmux attach || tmux new'"
alias rmzoneidentifier='find . -name "*:Zone.Identifier" -type f -delete'
alias hawkmon="ssh -t ubuntu@hawkmon.wyvern-arctic.ts.net -- screen -d -R"
alias arbok-wake="wakeonlan C8:7F:54:69:65:83"

# Shares current dir on port 8000
alias sharedir='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'

# I hate losing my place.
alias cd='pushd > /dev/null'
alias uncd='popd > /dev/null'

# Aliases that need parameters
function tomp3 {
    ffmpeg -i "$1" -q:a 0 -map a "$1.mp3"
}

function set730fan {
    USER=root
    IP="192.168.2.4"
    # Enable manual control
    ipmitool -I lanplus -H $IP -U $USER -P $PASS raw 0x30 0x30 0x01 0x00
    # Set overall fan speed (last byte should be 0x00 - 0x64)
    ipmitool -I lanplus -H $IP -U $USER -P $PASS raw 0x30 0x30 0x02 0xff 0x20
    # Make fan 5 a bit faster for the PCIe zone
    ipmitool -I lanplus -H $IP -U $USER -P $PASS raw 0x30 0x30 0x02 0x04 0x35
}

function set730fanhigh {
    USER=root
    IP="192.168.2.4"
    # Enable manual control
    ipmitool -I lanplus -H $IP -U $USER -P $PASS raw 0x30 0x30 0x01 0x00
    # Set overall fan speed (last byte should be 0x00 - 0x64)
    ipmitool -I lanplus -H $IP -U $USER -P $PASS raw 0x30 0x30 0x02 0xff 0x40
    # Make fan 5 a bit faster for the PCIe zone
    ipmitool -I lanplus -H $IP -U $USER -P $PASS raw 0x30 0x30 0x02 0x04 0x60
}

# Picks a colour based on the hostname.
function color_from_hostname {
    # Hostname specific overrides
    case ${HOSTNAME%%.*} in
        "charmeleon") c="8;2;216;78;56" ;;
        "charizard") c="8;2;183;88;25" ;;
        "abra") c="8;5;100" ;;
        "bellsprout") c="8;5;70" ;;
        "novae") c="8;5;55" ;;
        "hydrae") c="8;5;29" ;;
        "gyarados") c="8;5;30" ;;
    esac
    [ ! -z "$c" ] && echo $c && return
    # Generic hashing
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

# Makes the username have a red background if root
function color_from_username {
    if [ "$USER" == "root" ]; then
        echo 1
    else
        echo 0
    fi
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
containername () {
    if [ `echo $CONTAINER_ID` ]; then
        echo -n "/$CONTAINER_ID"
    fi
}
command_exists () {
    type "$1" &> /dev/null ;
}

# Customised prompt; shows git/venv status too
PROMPT_DIRTRIM=2
title () {
    PS1="\[\e]0;$1\a\]"'\[\e[4`color_from_hostname`m\]\[\e[1;37m\] \h`containername` \[\e[4`color_from_username`m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[48;5;30m\] `parse_git_branch``virtualenvname`> \[\e[0m\] '
}
title "\w"

# Set editor based on if we're in a VS Code shell or not
if [ -z $VSCODE_IPC_HOOK_CLI ]; then
    export EDITOR=vim
else
    export EDITOR=vim
    # This doesn't work after a shell reconnect, sadly
    # export EDITOR="code --wait"
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
if type keychain >/dev/null 2>/dev/null && [ -e $HOME/.ssh/id_ecdsa ]; then
    keychain -q --nogui $HOME/.ssh/id_ecdsa
    source $HOME/.keychain/$HOSTNAME-sh
fi

# Python
export PYENV_ROOT="$HOME/.pyenv"
export VIRTUAL_ENV_DISABLE_PROMPT=True
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if [ -e "$PYENV_ROOT/bin/pyenv" ]; then
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Go
export GOPATH=~/Programs/go

# PostgreSQL settings
export PGUSER=postgres

# Krew and custom bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$HOME/bin:$PATH"
