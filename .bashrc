
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [[ $machine == Mac ]]; then
    alias md5sum=md5
fi

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
source ~/.bash/infinite_fzf_history

if [[ `uname` == 'Linux' ]]; then
    PATH="$HOME/bin/linux:$HOME/.fzf/bin:${PATH}"
fi
PATH="$HOME/go/bin:$HOME/.fzf/bin:${PATH}"
PATH="$HOME/bin:${PATH}"

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
if [[ $machine != Mac ]]; then
    alias ls='ls --color=auto'
fi
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

source_if_exists ~/.fzf/shell/key-bindings.bash
#overwrite fzf history
if [[ $- =~ i ]]; then
    bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`infinite_fzf_history`\e\C-e\er\e^"'
fi


ninja_target_fzf() {
  if ! [ -e build.ninja ]; then
      return
  fi

  ninja -t targets all | cut -d: -f1 |
  fzf-tmux --format=reverse
}

git_branch_fzf() {
    if git rev-parse --show-toplevel 2>&1 > /dev/null; then
        git for-each-ref --format="%(refname)" refs/heads | cut -d/ -f3- | fzf-tmux --preview 'git lg --color=always --first-parent {}'
    fi
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
    bind '"\C-g\C-b": "$(git_branch_fzf)\e\C-e\er"'
    bind '"\C-g\C-d": "directory_fzf\n"'
    bind '"\C-g\C-r": "source ~/.bashrc\n"'
    bind -x '"\C-g\C-p": pet-select'
fi


is_in_git_repo () {
  git rev-parse HEAD > /dev/null 2>&1
}

source_if_exists ~/.bashrc.employer_specific

export EDITOR="vim"
export GOPATH=~/go
export GOROOT=~/go/go-1.14.1
export GO111MODULE=on

if command -v direnv > /dev/null; then
    eval "$(direnv hook bash)"
else
    echo "heads up: direnv not found on this system"
fi
