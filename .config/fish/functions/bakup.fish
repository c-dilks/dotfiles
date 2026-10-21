function bakup --description 'backup or un-backup files'
  if test (count $argv) -lt 2
    echo "usage: bakup <cp/mv> <filenames>..."
    echo "moves or copies each <filename> to <filename>.bak, and vice versa"
    return 2
  end

  set cmd $argv[1]
  set status_code 0

  for fname in $argv[2..-1]
    if string match --quiet --regex '\.bak$' -- $fname
      $cmd -v -- $fname (string replace --regex '\.bak$' '' -- $fname)
    else
      $cmd -v -- $fname $fname.bak
    end
    or set status_code $status
  end

  return $status_code
end
