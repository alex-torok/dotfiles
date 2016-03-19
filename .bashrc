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

function notify-mbp () {
    SSH_IP=`echo $SSH_CONNECTION | cut -f1 -d" "`
    echo $SSH_IP
    echo $1
    ssh -o StrictHostKeyChecking=no alextorok@$SSH_IP "hostname | echo; terminal-notifier -title $1 -message $2"
}
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="${BOLD}\t ${NORMAL}[\u@\h]${BOLD}${WHITE}\$(parse_git_branch) \
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

# Add timestamps to the history
HISTTIMEFORMAT="%d/%m/%y %T "

# Useful shortcuts
alias cd..='cd ..'
alias ..='cd ..'
alias remakeTests='./CleanTests.pl;./MakeTests.pl'

# Tmux alias
alias tmuxa='tmux a set-environment SSH_HOSTNAME $SSH_HOSTNAME'

# Git aliases
alias gits='git status'
alias gitf='git fetch'
alias gitc='git commit -m'
#!/bin/bash

# save as i.e.: git-authors and set the executable flag
alias git-authors='git ls-tree -r -z --name-only HEAD -- $1 | xargs -0 -n1 git blame --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr'


alias num2ip='~/test-farm-utilities/numToIp.rb'
alias ip2num='~/test-farm-utilities/ipToNum.rb'

#unit variables
#unit1='172.17.18.2'
#unit1='172.17.18.3'
unit1='10.12.52.134'
unit2='10.12.52.138'
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
