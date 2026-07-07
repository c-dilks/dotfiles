function aa --description 'run apptianer image'

  set im ''

  switch $argv[1]

    # see `qq` switch statement to understand what these cases are
    case 'b*'
      set im none
    case 'cai*'
      set im none
    case 'cal*'
      set im none
    case 'cl*'
      set im none
    case 'co*'
      set im none
    case 'd*'
      set im none
    case 'e*'
      set im none
    case 'f*'
      set im none
    case 'h*'
      set im none
    case 'i*'
      set im ~/containers/base_root_latest.sif
    case 'o*'
      set im none
    case 'q*'
      set im none
    case 'ss*'
      set im none
    case 't*'
      set im none
    case 'w*'
      set im none
    case '*'
      echo "error: unknown argument" >&2
      return 1
  end

  [ -z "$im" ] && echo "error: image name unknown" >&2 && return 1
  [ "$im" = "none" ] && return 0
  [ ! -f "$im" ] && echo "warning: cannot find image '$im'" >&2 && return 0

  apptainer run $im fish

end
