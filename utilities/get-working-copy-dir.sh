#!/bin/bash
# Lists all of the current paths for each pane in the current window
# and gets the directory name after "working-copy". This is used to show
# The git repo being worked on in the tmux window tabs
tmux list-panes -F "#{pane_current_path}" -t $1 | grep -Po '(?<=working-copy/)[^/]+' | sed 's_\(.*\)_ \1_'
