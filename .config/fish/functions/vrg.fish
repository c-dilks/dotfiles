function vrg --description 'open rg results in neovim tabs'
  nvim -p (rg -l $argv | sort)
end
