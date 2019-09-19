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
    LESS_TERMCAP_mb="$(printf "\e[01;14m")" \
    LESS_TERMCAP_md="$(printf "\e[01;38;5;14m")" \
    LESS_TERMCAP_so="$(printf "\e[01;37;1m")" \
    LESS_TERMCAP_us="$(printf "\e[04;38;5;214m")" \
    LESS_TERMCAP_me="$(printf "\e[0m")" \
    LESS_TERMCAP_se="$(printf "\e[0m")" \
    LESS_TERMCAP_ue="$(printf "\e[0m")" \
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
    PATH="$HOME/bin/linux:$HOME/.fzf/bin:${PATH}"
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

function git_ps1_string () {
    git rev-parse --git-dir > /dev/null 2>&1 && \
        git rev-parse HEAD &> /dev/null || exit
    echo " ($(parse_git_branch) - $(parse_git_age))"
}
function parse_git_branch () {
    __git_ps1 "%s"
}

function parse_git_age () {
    commit_relative_time=$(git rev-list -n1 --format="%cr" HEAD | tail -n1 | sed 's/^\s*//' | sed -r 's/([0-9]+) (.).+/\1\2/')
    echo $commit_relative_time
}

export PS1="${BOLD}\t ${NORMAL}[\u\$(decorated_hostname)${NORMAL}${WHITE}]${BOLD}${WHITE}\$(git_ps1_string) \
${NORMAL}${GREEN}\w\\n${BOLD}${KEY_ORANGE}\$${NORMAL} "

# cpp and h cscope
alias cppscope='find . | grep -P "\.(cpp|h)$" > cppscope.files && cscope -b -i ./cppscope.files'

alias ll='ls -l'
alias ls='ls --color=auto'

# Each shell gets it's own history file, but don't make a new one just when we re-source the bashrc
if [[ ! "${HISTFILE}" == *'bash_history_dir'* ]]; then
    HISTFILE="${HOME}/.bash_history_dir/$(date -u +%Y-%m-%d.%H.%M.%S)_$$"
    export HISTFILE
fi

# Immediately update the history
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# Ignore entries with a leading space
HISTCONTROL=ignoreboth
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

. $HOME/.shellrc.load

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(cat -n {} || tree -C {}) 2> /dev/null | head -$LINES'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind ?:toggle-preview"

[ -f ~/.fzf/shell/key-bindings.bash ] && source ~/.fzf/shell/key-bindings.bash


ninja_target_fzf() {
  if ! [ -e build.ninja ]; then
      return
  fi

  ninja -t targets all | cut -d: -f1 |
  fzf-tmux --format=reverse
}

directory_fzf() {
    dir=$(find -type d | fzf-tmux --preview 'ls {}')
    if [[ "$dir" != "" ]]; then
        clear
        cd "$dir"
    fi
}

# Binds
if [[ $- =~ i ]]; then
    bind '"\C-g\C-n": "$(ninja_target_fzf)\e\C-e\er"'
    bind '"\C-g\C-d": "directory_fzf\n"'
    bind '"\C-g\C-r": "source ~/.bashrc\n"'
    bind -x '"\C-g\C-p": pet-select'
fi


is_in_git_repo () {
  git rev-parse HEAD > /dev/null 2>&1
}

source_if_exists ~/.bashrc.employer_specific

export EDITOR="nvim"

fzf_history_preview="grep -B1 -xhFr {2..} ~/.bash_history_dir | grep '^#' | cut -d# -f2 | sort -nr | xargs -n1 -I[] date -d@[]"
# Search through all of the unique history files
terminal_fzf_history() {
    query_file=$1
    local fzf_ctrl_c_exit_code=130
    grep -hv ^\# $HISTFILE \
    | sort | uniq -c | sort -n \
    | $(__fzfcmd) --no-multi --tac --tiebreak=index \
    --bind "ctrl-r:execute(echo 1 >> $query_file; echo {q} >> $query_file)+unix-line-discard+print-query" \
      --preview "$fzf_history_preview" \
      --preview-window=right:28 \
    | sed "s/ *[0-9]* *//"
    echo ${PIPESTATUS[@]} | grep -q " $fzf_ctrl_c_exit_code " && echo '##########'
}

global_fzf_history() {
    start_query="$1"

    grep -hrv ^\# $HOME/.bash_history_dir \
    | sort | uniq -c | sort -n \
    | $(__fzfcmd) --no-multi --tac --tiebreak=index \
      --bind "ctrl-r:unix-line-discard+print-query" \
      --query "$start_query" \
      --preview "$fzf_history_preview" \
      --preview-window=right:28 \
    | sed "s/ *[0-9]* *//"
}

__fzf_history__() {
    exit_early_tempfile=$(mktemp)
    res=$(terminal_fzf_history $exit_early_tempfile)
    prev_query=$(cat $exit_early_tempfile)
    if [[ "$res" == '##########' ]]; then
        exit 1
    elif [[ "${prev_query}" != "" ]]; then
		query="$(cat $exit_early_tempfile | sed -n 2p)"
        res=$(global_fzf_history "$query")
    fi
    rm $exit_early_tempfile
    echo $res
}

alias tokencurl='curl -H "Authorization: Bearer $token"'
