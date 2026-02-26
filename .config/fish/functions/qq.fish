function qq --description 'open dev layout'

  set d ''
  set dir1 ''
  set dir2 ''
  set dir3 ''

  switch $argv[1]

    case 'b*';    set d ~/j/bihadro
    case 'calc*'; set d ~/j/calib/calcode
    case 'cali*'; set d ~/j/calib/calico
    case 'cl*';   set d ~/j/clas12root
    case 'co*';   set d ~/j/coatjava
    case 'd*';    set d ~/j/dispin
    case 'e*';    set d ~/j/env
    case 'f*';    set d ~/j/container-forge
    case 'h*';    set d ~/j/hipo-cpp; set dir1 $d/build
    case 'i*';    set d ~/j/iguana;   set dir1 $d/build
    case 'o*';    set d ~/j/orca
    case 'q*';    set d ~/j/dm/clas12-qadb
    case 't*';    set d ~/j/dm/clas12-timeline
    case 'w*';    set d ~/j/wok

    case '*'
      echo "error: unknown argument" >&2
      return 1
  end

  [ -z "$dir1" ] && set dir1 $d
  [ -z "$dir2" ] && set dir2 $d
  [ -z "$dir3" ] && set dir3 $d

  cd $dir1
  sleep 0.5
  i3-msg "split h"
  alacritty --working-directory $dir2 &
  disown
  sleep 0.5
  i3-msg "focus left; split v"
  alacritty --working-directory $dir3 &
  disown
  sleep 0.5
  i3-msg "focus right; resize grow left 300 px"
  sleep 0.5

end
