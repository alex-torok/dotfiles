#! /bin/bash
function print_working_copy_branches {
    for dir in ~/working-copy/* ; do
        if [ -d ${dir} ]; then
            git -C $dir rev-parse 2> /dev/null
            if [[ $? -eq 0 ]]; then
                pushd $dir > /dev/null
                branch_name=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
                echo -e "$(basename $dir):\e[32m$branch_name \e[39m"
                popd > /dev/null
            fi
        fi
    done
}

working_copy_fzf() {
    dir=$(print_working_copy_branches |
          fzf --layout=reverse --ansi |
          cut -d: -f1)
    if [[ ${dir} != "" ]]; then
        clear
        cd ~/working-copy/${dir}
    fi
}

function today {
    TODAY_DIR="$HOME/today/"
    DATE_DIR=$(date +'%Y-%m-%d')

    if [ ! -d  $TODAY_DIR$DATE_DIR ];
    then
        mkdir -p $TODAY_DIR$DATE_DIR
    fi;

    echo $TODAY_DIR$DATE_DIR
}

# add a binding if we are in an interactive shell
if [[ $- =~ i ]]; then
    bind '"\C-g\C-t": "$(today)\e\C-e"'
    bind '"\C-g\C-w": "working_copy_fzf\n"'
fi
