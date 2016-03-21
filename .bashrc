if tty -s
then
    BLACK="\[$(tput setaf 0)\]"
    RED="\[$(tput setaf 1)\]"
    GREEN="\[$(tput setaf 2)\]"
    YELLOW="\[$(tput setaf 3)\]"
    BLUE="\[$(tput setaf 4)\]"
    MAGENTA="\[$(tput setaf 5)\]"
    CYAN="\[$(tput setaf 6)\]"
    WHITE="\[$(tput setaf 7)\]"
    LIME_YELLOW="\[$(tput setaf 190)\]"
    POWDER_BLUE="\[$(tput setaf 153)\]"
    BOLD="\[$(tput bold)\]"
    NORMAL="\[$(tput sgr0)\]"
    BLINK="\[$(tput blink)\]"
    REVERSE="\[$(tput smso)\]"
    UNDERLINE="\[$(tput smul)\]"

    # Disable bullshit flow control
    stty -ixon
fi

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
function parse_git_age () {
git show HEAD --date=relative 2> /dev/null | egrep "^Date:" | cut -d":" -f2 | sed 's/^\s*//' # | sed  's/\(\d+\) \(.\).+/\1/'
}

export PS1="${BOLD}\t ${NORMAL}[\u@\h] ${BOLD}${WHITE}(\$(parse_git_branch) - \$(parse_git_age)) \
${NORMAL}${GREEN}\w\\n${BOLD}${RED}\$${NORMAL} "
# .bashrc
#export PS1="prompt: " 
# Source global definitions
# if [ -f /etc/bashrc ]; then
# 	. /etc/bashrc
# fi

# User specific aliases and functions
if [ -e ~/working-copy/test-farm/test-farm/util/toys/test-farm-helpers ]
then
    source ~/working-copy/test-farm/test-farm/util/toys/test-farm-helpers
    alias etd='echo $TESTDIR'
fi

function tags () {
    #clean older info
    rm -rf tags
    rm -rf cscope.files
    rm -rf cscope.out
    # generate new info
    echo "Creating ctags"
    ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .
    echo "Finding files for cscope"
    find | egrep -i "\.(c|h|cpp)$" > cscope.files
    echo "Creating cscope"
    cscope -Rb
}
# cpp and h cscope
alias cppscope='find . | grep -P "\.(cpp|h)$" > cppscope.files && cscope -b -i ./cppscope.files'

# Add timestamps to the history
HISTTIMEFORMAT="%d/%m/%y %T "

# Useful shortcuts
alias cd..='cd ..'
alias ..='cd ..'
alias remakeTests='./CleanTests.pl;./MakeTests.pl'

# Git aliases
alias gits='git status'
alias gitf='git fetch'
alias gitc='git commit -m'
#!/bin/bash

# save as i.e.: git-authors and set the executable flag
alias git-authors='git ls-tree -r -z --name-only HEAD -- $1 | xargs -0 -n1 git blame --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr'


alias num2ip='~/test-farm-utilities/numToIp.rb'
alias ip2num='~/test-farm-utilities/ipToNum.rb'

alias vnc='vncviewer'

function scpi {
    if [ $# -eq 1 ]
    then
         unit=--5800
    else
         unit=$2
    fi
    port=`getport --ip $1 $unit --noout`
    scpiclient --ip $1 --port $port
}

function viavnc {

        vncviewer $1 -name $1 &
}

PATH="/home/tor59451/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/tor59451/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/tor59451/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/tor59451/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/tor59451/perl5"; export PERL_MM_OPT;


alias debugperl='perl -d:Ptkdb'

#source ${HOME}/nest/config/nest_bashrc

. $HOME/.shellrc.load
