function bakup --description 'backup or un-backup a file'
  if test (count $argv) -lt 2
    echo "usage: bakup <cp/mv> <filename>"
    echo "moves or copies <filename> to <filename>.bak, and vice versa"
    return 2
  end
  set cmd "$argv[1]"
  set fname "$argv[2]"
  if string match --quiet --regex '\.bak$' -- "$fname"
    $cmd -v $fname $(echo $fname | sed 's;\.bak$;;')
  else
    $cmd -v $fname $fname.bak
  end
end
