function ssha --description 'add SSH keys'
  # FIXME: port this
  # if [[ "`hostname`" =~ "ifarm" ]]; then
  #   echo "kill current ssh-agent..."
  #   ssh-agent -k
  #   echo "kill any other ssh-agent processes..."
  #   pkill -U $USER ssh-agent
  #   echo "restarting a new ssh-agent..."
  #   eval "$(ssh-agent -s)"  # must be HERE (don't replace with bin/ssh_agent_start)
  #   echo "export `env|grep SSH_AGENT_PID`" > $HOME/.sshenv.fish # NB: sourced in environ.fish
  #   echo "export `env|grep SSH_AUTH_SOCK`" >> $HOME/.sshenv.fish
  #   chmod 600 $HOME/.sshenv
  # fi
  ssh-add -t 8h (ls $HOME/.ssh/*.pub | sed 's;\.pub$;;')
end
