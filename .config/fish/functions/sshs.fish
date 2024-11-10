function sshs --description 'use an existing ssh-agent'
  set -l env_file $HOME/.sshenv.fish
  if test -f $env_file
    source $env_file
  else
    echo "WARNING: $env_file does not exist"
  end
end
