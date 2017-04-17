#! /bin/bash
function print_working_copy_branches {
    for dir in ~/working-copy/* ; do
        if [ -d ${dir} ]; then
            git -C $dir rev-parse 2> /dev/null
            if [[ $? -eq 0 ]]; then
                pushd $dir > /dev/null
                branch_name=`git rev-parse --abbrev-ref HEAD`
                echo -e "$dir \e[32m$branch_name \e[39m"
                popd > /dev/null
            fi
        fi
    done
}

