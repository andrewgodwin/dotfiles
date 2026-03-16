# If not running interactively, don't do anything
[[ -o interactive ]] || return

# Picks a colour based on the hostname.
color_from_hostname() {
    local c
    case ${HOST%%.*} in
        charmeleon) c="8;2;216;78;56" ;;
        charizard) c="8;2;183;88;25" ;;
        abra) c="8;5;100" ;;
        bellsprout) c="8;5;70" ;;
        novae) c="8;5;55" ;;
        hydrae) c="8;5;29" ;;
        gyarados) c="8;5;30" ;;
        shuckle) c="8;5;136" ;;
        aurorae) c="8;5;99" ;;
    esac
    [[ -n "$c" ]] && echo "$c" && return
    # Generic hashing
    local hash=$({ echo $USER; hostname; } | md5sum | awk '{print $1}')
    case ${hash[-1]} in
        0) c=5 ;; # purple
        1) c=6 ;; # cyan
        2) c=2 ;; # green
        3) c=2 ;; # green
        4) c=4 ;; # blue
        5) c=4 ;; # blue
        6) c=6 ;; # cyan
        7) c=6 ;; # cyan
        8) c=5 ;; # purple
        9) c=5 ;; # purple
        a) c=4 ;; # blue
        b) c=2 ;; # green
        c) c=5 ;; # purple
        d) c=5 ;; # purple
        e) c=4 ;; # blue
        f) c=6 ;; # cyan
    esac
    echo "$c"
}

# Makes the username have a red background if root
color_from_username() {
    if [[ "$USER" == "root" ]]; then
        echo 1
    else
        echo 0
    fi
}

# VCS functions
parse_git_branch() {
    if [[ -d .git || -d ../.git || -d ../../.git || -d ../../../.git || -d ../../../../.git ]]; then
        git name-rev HEAD 2>/dev/null | sed 's#HEAD \(.*\)#git:\1 #'
    fi
}

virtualenvname() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo -n "ve:${VIRTUAL_ENV:t} "
    fi
}

containername() {
    if [[ -n "$CONTAINER_ID" ]]; then
        echo -n "/$CONTAINER_ID"
    fi
}

# Customised prompt; shows git/venv status too
# %2~ is the zsh equivalent of PROMPT_DIRTRIM=2
_prompt_title='%~'

title() {
    _prompt_title="$1"
}

precmd() {
    # Set terminal title
    print -Pn "\e]0;${_prompt_title}\a"

    local e=$'\e'
    local hc=$(color_from_hostname)
    local uc=$(color_from_username)
    local git=$(parse_git_branch)
    local venv=$(virtualenvname)
    local ctr=$(containername)

    PROMPT="%{${e}[4${hc}m${e}[1;37m%} %m${ctr} %{${e}[4${uc}m${e}[1;37m%} %n %{${e}[47m${e}[1;30m%} %2~ %{${e}[0m${e}[1;37m${e}[48;5;30m%} ${git}${venv}> %{${e}[0m%} "
}

title '%~'
