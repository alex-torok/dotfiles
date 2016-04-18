function fish_right_prompt -d "Write out the right prompt"
    set __fish_git_prompt_show_informative_status 1
    printf '%s \n' (__fish_git_prompt)
end
