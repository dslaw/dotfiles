# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


# Prompt with git branch status
git_branch() {
    git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||'
}

git_dirty() {
    git status -s --ignore-submodules=dirty 2> /dev/null
}

set_prompt() {
    last_command=$?
    gitbranch=$(git_branch)
    dirty=$(git_dirty)

    Reset='\[\e[00m\]'
    White='\[\e[01;37m\]'

    Light_Blue='\[\e[01;34m\]'
    Light_Green='\[\e[01;32m\]'
    Light_Cyan='\[\e[01;36m\]'
    Light_Red='\[\e[01;31m\]'
    Light_Purple='\[\e[01;35m\]'
    Light_Gray='\[\e[00;37m\]'

    Blue='\[\e[00;30m\]'
    Green='\[\e[00;32m\]'
    Cyan='\[\e[00;36m\]'
    Red='\[\e[00;31m\]'
    Purple='\[\e[00;35m\]'
    Dark_Gray='\[\e[01;30m\]'
    Yellow='\[\e[00;33m\]'

    PS1="$Purple\\u"
    PS1+="$Light_Gray in "
    PS1+="$Light_Red$(pwd)    "

    if [ $gitbranch ]; then
        if [ -z "$dirty" ]; then
            PS1+="$Light_Blue[ $gitbranch $Light_Blue]"
        else
            PS1+="$Light_Blue[ $Red$gitbranch± $Light_Blue]"
        fi
    fi


    if [[ $last_command == 0 ]]; then
        PS1+="\n$Light_Gray>>>$Reset "
    else
        PS1+="\n$Red>>>$Reset "
    fi
}

PROMPT_COMMAND='set_prompt'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

firefox="eval ~/bin/firefox/firefox"

