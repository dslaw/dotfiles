# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~/.bashrc ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# System
case "$OSTYPE" in
    solaris*) OS='Solaris' ;;
    darwin*)  OS='OSX' ;;
    linux*)   OS='Linux' ;;
    bsd*)     OS='BSD' ;;
    *)        OS='Unknown' ;;
esac

# History
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

# Options
shopt -s checkwinsize
if [[ OS == "Linux" ]]; then
    shopt -s globstar
fi

# Load aliases
if [[ -f ~/.aliases ]]; then
    source ~/.aliases
fi

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

    Blue='\[\e[00;34m\]'
    Green='\[\e[00;32m\]'
    Cyan='\[\e[00;36m\]'
    Red='\[\e[00;31m\]'
    Purple='\[\e[00;35m\]'
    Dark_Gray='\[\e[01;30m\]'
    Yellow='\[\e[00;33m\]'

    PS1="$Red\u "

    if [[ $PWD == $HOME ]]; then
        PS1+="$Purple[~] "
    else
        if [[ $PWD =~ $HOME ]]; then
            PS1+="$Purple[~] "
        else
            PS1+="$Purple[${PWD%%/${PWD#*/*/}}] "
        fi

        curr=${PWD##*/}
        if [[ $curr != "" ]]; then
            PS1+="$Purple[${PWD##*/}] "
        fi
    fi

    if [ $gitbranch ]; then
        if [ -z "$dirty" ]; then
            PS1+="$Blue[$Green$gitbranch$Blue]"
        else
            PS1+="$Blue[$Light_Red$gitbranch ±$Blue]"
        fi
    fi

    #hash conda && [[ -n $CONDA_DEFAULT_ENV ]] && [[ ! $CONDA_DEFAULT_ENV =~ 'root' ]] && PS1+=" $Blue($Yellow$CONDA_DEFAULT_ENV$Blue)"
    case $CONDA_DEFAULT_ENV in
        "")    ;;
        root*) ;;
        *)     PS1+="$Blue($Yellow$CONDA_DEFAULT_ENV$Blue)" ;;
    esac

    if [[ $last_command == 0 ]]; then
        PS1+="\n$Light_Gray::$Reset "
    else
        PS1+="\n$Red::$Reset "
    fi
}

PROMPT_COMMAND='set_prompt'

