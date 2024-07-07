#!/usr/bin/env fish

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

# paths
set -xp PATH . ~/bin ~/builds/bin
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
set -x RBENV_ROOT ~/.rbenv
if test -d $RBENV_ROOT
  set -xp PATH $RBENV_ROOT/bin
  eval "$(rbenv init - fish)" # use rbenv ruby shim
  set -x PYTHON (which python) # for pycall gem
end

##################################################################################

# ripgrep
if test -f ~/.ripgrep
  set -x RIPGREP_CONFIG_PATH ~/.ripgrep
end

# fzf
if command -sq fzf
  fzf --fish | source
end

# ssh-agent
if test -f ~/.sshenv.fish
  source ~/.sshenv.fish
end

##################################################################################

# ROOT
if test -d ~/builds/root
  cd ~/builds/root
  source bin/thisroot.fish
  prevd
end

# RubyROOT
if test -d ~/builds/RubyROOT-install
  set -xp RUBYLIB ~/builds/RubyROOT-install/lib/ruby
end

# clas12root
if test -d ~/j/clas12root
  set -x CLAS12ROOT ~/j/clas12root
  set -xp PATH $CLAS12ROOT/bin
  set -xp LD_LIBRARY_PATH $CLAS12ROOT/lib
end

# coatjava
if test -d ~/j/coatjava/coatjava
  set -x COATJAVA ~/j/coatjava/coatjava
  set -xp PATH $COATJAVA/bin
end
test -n "$COATJAVA" && set -xp CLASSPATH "$COATJAVA/lib/clas/*"

# rcdb
if test -d ~/j/rcdb
  set -x RCDB_HOME ~/j/rcdb
  set -xp PATH $RCDB_HOME $RCDB_HOME/bin
  set -xp PYTHONPATH $RCDB_HOME/python
end
test -n "$RCDB_HOME" && set -xp CLASSPATH "$RCDB_HOME/java/out/artifacts/rcdb_jar/*"
