function b --description 'execute something with bash, namely, sourcing environment files'
  exec bash -c "$argv; exec fish"
end
