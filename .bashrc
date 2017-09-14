function source_if_exists () {
    [ -f $1 ] && source $1
}

# ssh stuff because Mike is a butt
eval `ssh-agent -s` 2>&1 > /dev/null
ssh-add -k ~/.ssh/id_rsa 2>&1 > /dev/null


. ~/third-party/z/z.sh
. ~/third-party/up/src/.bash_functions
. ~/third-party/up/completion/up
. ~/.bash_functions.sh


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

function httpserver () {
    local port=${1:-8081}
    python -m SimpleHTTPServer ${port}
}

function parse_git_branch () {
    __git_ps1 | sed -r 's_ \((.+)\)_\1_'
}
function parse_git_age () {
git log -n1 --format="%ar" 2> /dev/null | sed 's/^\s*//' | sed -r 's/([0-9]+) (.).+/\1\2/'
}

export PS1="${BOLD}\t ${NORMAL}[\u@${BLUE}\h${WHITE}] ${BOLD}${WHITE}(\$(parse_git_branch) - \$(parse_git_age)) \
${NORMAL}${GREEN}\w\\n${BOLD}${RED}\$${NORMAL} "

# cpp and h cscope
alias cppscope='find . | grep -P "\.(cpp|h)$" > cppscope.files && cscope -b -i ./cppscope.files'

alias ll='ls -l'
alias ls='ls --color=auto'
# Add timestamps to the history
HISTTIMEFORMAT="%d/%m/%y %T "

# Useful shortcuts
alias cd..='cd ..'
alias ..='cd ..'

# Git aliases
alias gits='git status'
alias gdc='git diff --cached'
alias gdt='git difftool'
alias gdtc='git difftool --cached'
alias gitf='git fetch'
alias gita='git add'
alias gitc='git commit -m'

# save as i.e.: git-authors and set the executable flag
alias git-authors='git ls-tree -r -z --name-only HEAD -- $1 | xargs -0 -n1 git blame --line-porcelain HEAD |grep  "^author "|sort|uniq -c|sort -nr'

alias xvfb='Xvfb :99 & &>/dev/null; export DISPLAY=:99'

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

PATH="/home/tor59451/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/tor59451/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/tor59451/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/tor59451/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/tor59451/perl5"; export PERL_MM_OPT;

alias debugperl='perl -d:Ptkdb'


. $HOME/.shellrc.load

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(coderay {} || cat {} || tree -C {}) 2> /dev/null | head -$LINES'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind ?:toggle-preview"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


ninja_target_fzf() {
  if ! [ -e build.ninja ]; then
      return
  fi

  ninja -t targets all | cut -d: -f1 |
  fzf-tmux
}
# add a binding if we are in an interactive shell
if [[ $- =~ i ]]; then
    bind '"\C-g\C-n": "$(ninja_target_fzf)\e\C-e\er"'
fi


# GIT heart FZF - Courtesy of junegunn
# -------------

is_in_git_repo () {
  git rev-parse HEAD > /dev/null 2>&1
}

# unalias gf
# gf () {
#   is_in_git_repo || return
#   git -c color.status=always status --short |
#   fzf-tmux -m --ansi --nth 2..,.. \
#     --preview 'NAME="$(cut -c4- <<< {})" &&
#                (git diff --color=always "$NAME" | sed 1,4d; cat "$NAME") | head -'$LINES |
#   cut -c4-
# }

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-tmux --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-tmux --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph |
  fzf-tmux --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# bind '"\er": redraw-current-line'
# bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
# bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
# bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
# bind '"\C-g\C-h": "$(gh)\e\C-e\er"'

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -$LINES '" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'vim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}
