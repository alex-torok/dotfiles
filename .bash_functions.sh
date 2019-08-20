#! /bin/bash
code_dir="$HOME/code"
function print_code_branches {
    for dir in $(ls $code_dir) ; do
        dir="$code_dir/$dir"
        if [ -d $dir ]; then
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

code_fzf() {
    dir=$(print_code_branches |
          fzf --layout=reverse --ansi |
          cut -d: -f1)
    if [[ ${dir} != "" ]]; then
        clear
        cd ${code_dir}/${dir}
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
    bind '"\C-g\C-w": "code_fzf\n"'
fi

