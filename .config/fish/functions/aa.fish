function aa --description 'run apptianer image'

  set im ''

  switch $argv[1]

    case 'b*'
      set dir0 ~/j/bihadro
    case 'cai*'
      set dir0 ~/j/caiman
    case 'cal*'
      set dir0 ~/j/calcode
    case 'cl*'
      set dir0 ~/j/clas12root
    case 'co*'
      set dir0 ~/j/coatjava
    case 'd*'
      set dir0 ~/j/dispin
    case 'e*'
      set dir0 ~/j/env
    case 'f*'
      set dir0 ~/j/container-forge
    case 'h*'
      set dir0 ~/j/hipo-cpp
      set dir1 $dir0/build
    case 'i*'
      set im ~/containers/base_root_latest.sif
    case 'o*'
      set dir0 ~/j/orca
    case 'q*'
      set dir0 ~/j/dm/clas12-qadb
    case 'ss*'
      set dir0 ~/j/clas-stringspinner
      set dir1 $dir0/build
    case 't*'
      set dir0 ~/j/dm/clas12-timeline
    case 'w*'
      set dir0 ~/j/wok
    case '*'
      echo "error: unknown argument" >&2
      return 1
  end

  [ -z "$im" ] && echo "error: image name unknown" >&2 && return 1
  [ "$im" = "none" ] && return 0
  [ ! -f "$im" ] && echo "warning: cannot find image '$im'" >&2 && return 0

  apptainer run $im fish

end
