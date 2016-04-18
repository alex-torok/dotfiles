function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

    # Show last execution time and growl notify if it took long enough
    if test $CMD_DURATION -a $CMD_DURATION -gt 10000
        set duration (math $CMD_DURATION / 1000)
        ~/utilities/notify-mbp.sh "Returned $last_status, took $duration seconds" "$history[1]"
    end

  printf "%s " (date +%T)
  # User
  set_color $fish_color_user
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  echo -n ':'

  # PWD
  set_color $fish_color_cwd
  echo -n (pwd)
  set_color normal

  echo

  if not test $last_status -eq 0
    set_color $fish_color_error
  else
    set_color green
  end

  echo -n '➤ '
  set_color normal
end
