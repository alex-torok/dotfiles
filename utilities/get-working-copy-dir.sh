#!/bin/bash
tmux list-panes -F "#{pane_current_path}" -t $1 | grep -Po '(?<=working-copy/)[^/]+' | sed 's_\(.*\)_\1_'
