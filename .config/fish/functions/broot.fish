function broot --description 'open ROOT a file in a TBrowser'
  root -l $argv -e 'new TBrowser'
end
