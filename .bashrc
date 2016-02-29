# .bashrc
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 6)\]\t \[$(tput setaf 2)\][\[$(tput setaf 3)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 3)\]\h\[$(tput setaf 7)\]\$(parse_git_branch) \[\033[00m\]\w\[$(tput setaf 2)\]\[$(tput bold)\]]\[$(tput setaf 4)\]\\n\$ \[$(tput sgr0)\]"
#export PS1="prompt: " 
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
source ~/working-copy/test-farm/test-farm/util/toys/test-farm-helpers
alias etd='echo $TESTDIR'

# Add timestamps to the history
HISTTIMEFORMAT="%d/%m/%y %T "

# Useful shortcuts
alias cd..='cd ..'
alias ..='cd ..'
alias remakeTests='./CleanTests.pl;./MakeTests.pl'

# Disable bullshit flow control
stty -ixon
# Tmux alias
# alias tmux='tmux -2'

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
