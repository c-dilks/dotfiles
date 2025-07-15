function ssha --description 'add SSH keys'
  if on_ifarm
    echo "kill current ssh-agent..."
    ssh-agent -k
    echo "kill any other ssh-agent processes..."
    pkill -U $USER ssh-agent
    echo "restarting a new ssh-agent..."
    eval (ssh-agent -c)  # must be HERE (don't replace with bin/ssh_agent_start)
    echo "set -x" (env | grep SSH_AGENT_PID | sed 's/=/ /g') > $HOME/.sshenv.fish # NB: sourced in environ.fish
    echo "set -x" (env | grep SSH_AUTH_SOCK | sed 's/=/ /g') >> $HOME/.sshenv.fish
    chmod 600 $HOME/.sshenv.fish
  end
  ssh-add -t 11h (ls $HOME/.ssh/*.pub | sed 's;\.pub$;;')
end
