SSH_IP=`echo $SSH_CONNECTION | cut -f1 -d" "`
ssh -t -o StrictHostKeyChecking=no alextorok@$SSH_IP 2> /dev/null "/usr/local/bin/terminal-notifier -title '$1' -message '$2'"
