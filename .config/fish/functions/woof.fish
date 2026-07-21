function woof --description 'open dev layout'

  set dir0 '' # default directory
  set dir1 '' # directory for 1st window
  set dir2 '' # directory for 2nd window
  set dir3 '' # directory for 3rd window

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
      set dir0 ~/j/iguana
      set dir1 $dir0/build
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

  [ -z "$dir0" ] && echo "error: variable \$dir0 not set" >&2 && return 1
  [ ! -d "$dir0" ] && echo "error: \$dir0='$dir0' does not exist" >&2 && return 1

  [ -z "$dir1" ] && set dir1 $dir0
  [ -z "$dir2" ] && set dir2 $dir0
  [ -z "$dir3" ] && set dir3 $dir0
  [ ! -d "$dir1" ] && echo "warning: \$dir1='$dir1' does not exist" >&2 && set dir1 $dir0
  [ ! -d "$dir2" ] && echo "warning: \$dir2='$dir2' does not exist" >&2 && set dir2 $dir0
  [ ! -d "$dir3" ] && echo "warning: \$dir3='$dir3' does not exist" >&2 && set dir3 $dir0

  cd $dir1
  sleep 0.5
  i3-msg "split h"
  alacritty --working-directory $dir2 --command fish -c "aa $argv[1]; exec fish" &
  disown

  sleep 0.5
  i3-msg "focus left; split v"
  alacritty --working-directory $dir3 --command fish -c "aa $argv[1]; exec fish" &
  disown

  sleep 0.5
  i3-msg "focus right; resize grow left 300 px; split v; layout stacking"
  alacritty --working-directory $dir3 &
  disown

  sleep 0.5
  i3-msg "focus up"
  aa $argv[1]

end
