function arf --description 'run apptianer image'

  set im ''
  set cmd ''

  switch $argv[1]

    # see `qq` switch statement to understand what these cases are
    case 'b*'
      set cmd x/run dev -- fish
    case 'cai*'
      return 0
    case 'cal*'
      return 0
    case 'cl*'
      return 0
    case 'co*'
      return 0
    case 'd*'
      return 0
    case 'e*'
      return 0
    case 'f*'
      return 0
    case 'h*'
      return 0
    case 'i*'
      set im ~/containers/base_root_latest.sif
    case 'o*'
      return 0
    case 'q*'
      return 0
    case 'ss*'
      return 0
    case 't*'
      return 0
    case 'w*'
      return 0
    case '*'
      echo "error: unknown argument" >&2
      return 1
  end

  if test -n "$cmd"
    $cmd
  else if test -n "$im"
    if test -e "$im"
      apptainer run $im fish
    else
      echo "warning: cannot find image '$im'" >&2
      return 0
    end
  end

end
