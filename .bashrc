function source_if_exists () {
    [ -f $1 ] && source $1
}

# if [ -z "$SSH_AUTH_SOCK" ] && [ -z "$TMUX" ]; then
#     eval `ssh-agent -s` &> /dev/null
#     ssh-add -k ~/.ssh/id_rsa &> /dev/null
# fi
# if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
#     ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
# fi
# export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;

man() {
    env \
    LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
    LESS_TERMCAP_md="$(printf "\e[1;31m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
    LESS_TERMCAP_us="$(printf "\e[1;32m")" \
    man "${@}"
}

alias clipboard="ssh macbook pbcopy"

source ~/third-party/git-prompt.sh
source ~/third-party/up/src/.bash_functions
source ~/third-party/up/completion/up
source ~/.bash_functions.sh

source ~/.bash/colors
source ~/.bash/hostname_decoration

if [[ `uname` == 'Linux' ]]; then
    PATH="$HOME/bin/linux:${PATH}"
fi

function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}

function httpserver () {
    local port=${1:-8081}
    local hostname=`hostname`
    echo "Starting http server at http://${hostname}:${port}"
    python -m SimpleHTTPServer ${port}
}

function git_ps2_string () {
    git rev-parse --git-dir > /dev/null 2>&1 || exit
    echo " ($(parse_git_branch) - $(parse_git_age))"
}
function parse_git_branch () {
    __git_ps1 | sed -r 's_ \((.+)\)_\1_'
}
function parse_git_age () {
    git rev-list -n1 --format="%ar" HEAD | tail -n1 | sed 's/^\s*//' | sed -r 's/([0-9]+) (.).+/\1\2/'
}

export PS1="${BOLD}\t ${NORMAL}[\u\$(decorated_hostname)${NORMAL}${WHITE}]${BOLD}${WHITE}\$(git_ps2_string) \
${NORMAL}${GREEN}\w\\n${BOLD}${KEY_ORANGE}\$${NORMAL} "

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
alias gd='git diff'
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

. $HOME/.shellrc.load

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(cat -n {} || tree -C {}) 2> /dev/null | head -$LINES'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind ?:toggle-preview"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


ninja_target_fzf() {
  if ! [ -e build.ninja ]; then
      return
  fi

  ninja -t targets all | cut -d: -f1 |
  fzf-tmux
}

# Binds
if [[ $- =~ i ]]; then
    bind '"\C-g\C-n": "$(ninja_target_fzf)\e\C-e\er"'
    bind -x '"\C-g\C-p": pet-select'
fi


# GIT heart FZF - Courtesy of junegunn
# -------------

is_in_git_repo () {
  git rev-parse HEAD > /dev/null 2>&1
}




