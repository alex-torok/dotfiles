# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tor59451/.fzf/bin* ]]; then
  export PATH="$PATH:/home/tor59451/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/tor59451/.fzf/man* && -d "/home/tor59451/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/tor59451/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/tor59451/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/tor59451/.fzf/shell/key-bindings.bash"

