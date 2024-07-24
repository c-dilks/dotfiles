function sshk --description 'remove broken control master sockets'
  rm -v ~/.ssh/cm/*.sock
end
