#!/usr/bin/env fish

set -l home_dilks /home/dilks

# main
set -x EDITOR nvim

# manpage coloring
set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;38;5;74m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[38;5;246m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[04;38;5;146m'

# ls coloring
set -gx LS_COLORS 'di=01;33:ln=01;32:mi=01;30:ex=01;36'

# paths
set -xp PATH . $home_dilks/bin $home_dilks/builds/bin
set -xp CLASSPATH . # java class path

##################################################################################

# cmake
if command -sq ninja
  set -x CMAKE_GENERATOR Ninja
end

# python shims ### FIXME use virtualfish, or 'abbr workhere 'source .venv/bin/activate.fish'
# if type virtualenvwrapper.sh > /dev/null; then
#   source virtualenvwrapper.sh
# fi

# ruby shims
if command -sq ruby && command -sq gem
  # use local ruby gems
  set -xp PATH (ruby -r rubygems -e 'puts Gem.user_dir')/bin
end
set -x RBENV_ROOT $home_dilks/.rbenv
if test -d $RBENV_ROOT
  set -xp PATH $RBENV_ROOT/bin
  eval "$(rbenv init - fish)" # use rbenv ruby shim
  set -x PYTHON (which python) # for pycall gem
end

##################################################################################

# ripgrep
if test -f $home_dilks/.ripgrep
  set -x RIPGREP_CONFIG_PATH $home_dilks/.ripgrep
end

# fzf
if command -sq fzf
  if command -sq rg
    set -x FZF_DEFAULT_COMMAND '[ -f compile_commands.json -a -f .gitignore ] && rg --files --no-ignore || rg --files --no-ignore-parent'
    set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  end
  fzf --fish | source
end

# ssh-agent
if test -f $home_dilks/.sshenv.fish
  source $home_dilks/.sshenv.fish
end

##################################################################################

# ROOT
if test -d $home_dilks/builds/root
  cd $home_dilks/builds/root
  source bin/thisroot.fish
  prevd
end

# RubyROOT
if test -d $home_dilks/builds/RubyROOT-install
  set -xp RUBYLIB $home_dilks/builds/RubyROOT-install/lib/ruby
end

# clas12root
if test -d $home_dilks/j/clas12root
  set -x CLAS12ROOT $home_dilks/j/clas12root
  set -xp PATH $CLAS12ROOT/bin
  set -xp LD_LIBRARY_PATH $CLAS12ROOT/lib
end

# coatjava
if test -d $home_dilks/j/coatjava/coatjava
  set -x COATJAVA $home_dilks/j/coatjava/coatjava
  set -xp PATH $COATJAVA/bin
end
test -n "$COATJAVA" && set -xp CLASSPATH "$COATJAVA/lib/clas/*"

# rcdb
if test -d $home_dilks/j/rcdb
  set -x RCDB_HOME $home_dilks/j/rcdb
  set -xp PATH $RCDB_HOME $RCDB_HOME/bin
  set -xp PYTHONPATH $RCDB_HOME/python
end
test -n "$RCDB_HOME" && set -xp CLASSPATH "$RCDB_HOME/java/out/artifacts/rcdb_jar/*"

##################################################################################

# ifarm stuff
if string match --regex "ifarm" (hostname)
  set -x MAVEN_OPTS -Djava.io.tmpdir=/volatile/clas12/users/dilks/tmp
end
