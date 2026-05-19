abbr cp 'cp -v'
abbr mv 'mv -v'
abbr rm 'rm -v'
abbr open 'xdg-open'

# zellij
abbr zz 'zellij --layout welcome attach --create zzz'

# bass
abbr bsource 'bass source'

# ROOT
abbr rootl 'root -l'
abbr rootq 'root -l -b -q'

# tmux
abbr tmuxa 'tmux a -t'
abbr tmuxs 'tmux new -s'
abbr tmuxl 'tmux ls'

# neovim
abbr vim 'nvim'
abbr vi 'nvim'
abbr v 'nvim'
abbr vd 'nvim -d'
abbr ovim 'vim'

# meson
abbr msw 'meson setup --wipe'
abbr mi 'meson install -q'
abbr mtv 'stdbuf -o0 meson test --verbose --print-errorlogs --no-stdsplit'

# docker
abbr dri 'docker run -it --rm'

# apptainer
abbr apprs 'apptainer run --fakeroot --writable-tmpfs --no-mount bind-paths --contain --cleanenv'

# clusters
abbr sq "squeue --me --format '%.18i %.30j %.8T %.10M %.10l %Q'"
abbr jcacheq "jcache pendingRequest -u $USER"
abbr jasmineq "jcache pendingRequest -u $USER"

# qadb
abbr mmm "modify.sh misc"

# coatjava
abbr cjb "./build-coatjava.sh -T8"
abbr cjc "./build-coatjava.sh --clean"
abbr cjcb "./build-coatjava.sh --clean && ./build-coatjava.sh -T8"

# shortcut directories
abbr bbb "cd $HOME/j/bihadro"
abbr ccc "cd $HOME/j/coatjava"
abbr dis "cd $HOME/j/dispin"
abbr eee "cd $HOME/j/env"
abbr fff "cd $HOME/j/container-forge"
abbr hhh "cd $HOME/j/hipo-cpp"
abbr iii "cd $HOME/j/iguana"
abbr lll "cd $HOME/j/calcode"
abbr nnn "cd $HOME/j/clastools"
abbr ooo "cd $HOME/j/orca"
abbr qqq "cd $HOME/j/dm/clas12-qadb"
abbr sss "cd $HOME/j/clas-stringspinner"
abbr ttt "cd $HOME/j/dm/clas12-timeline"
abbr vvv "cd $HOME/j/clas12-validation"
