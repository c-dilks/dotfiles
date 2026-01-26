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

# ls coloring
set -gx LS_COLORS 'di=01;33:ln=01;32:mi=01;30:ex=01;36'

# note: don't append/prepend array variables in the login shell, since:
# - spawning an interactive shell would append/prepend a SECOND time
# - we can't change the login shell's array variables without logging out
# - applying this idea to all variables below, to be strict
if status --is-interactive

  # paths
  set -xp PATH . $HOME/bin $HOME/bin.private
  if not in_apptainer_container
    set -xp PATH $HOME/builds/bin
  end

  ##################################################################################
  # CUSTOM SETTINGS
  ##################################################################################

  # cmake
  if command -sq ninja
    # prefer Ninja over Makefile
    set -x CMAKE_GENERATOR Ninja
    # make sure `compile_commands.json` always gets generated, for `clangd` support
    set -x CMAKE_EXPORT_COMPILE_COMMANDS ON
  end

  # ripgrep
  if test -f $HOME/.ripgrep
    set -x RIPGREP_CONFIG_PATH $HOME/.ripgrep
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
  if test -f $HOME/.sshenv.fish
    source $HOME/.sshenv.fish
  end

  ##################################################################################
  # INSTALLED SOFTWARE PATHS etc.
  ##################################################################################

  if not in_apptainer_container # do NOT conflict with apptainer container's stuff

    # --------------------------------------------------------------------------------
    # software which will be OVERRIDDEN by 'ifarm' modules (cf. below)
    # --------------------------------------------------------------------------------

    # python shims ### FIXME use virtualfish, or 'abbr workhere 'source .venv/bin/activate.fish'
    # if type virtualenvwrapper.sh > /dev/null; then
    #   source virtualenvwrapper.sh
    # fi

    # ruby shims
    if command -sq ruby && command -sq gem
      # use local ruby gems
      set -xp PATH (ruby -r rubygems -e 'puts Gem.user_dir')/bin
    end
    # set -x RBENV_ROOT $HOME/.rbenv
    # if test -d $RBENV_ROOT
    #   if not on_ifarm ### FIXME: having trouble with fish + rbenv + ifarm
    #     set -xp PATH $RBENV_ROOT/bin
    #     eval "(rbenv init - fish)" # use rbenv ruby shim
    #     set -x PYTHON (which python) # for pycall gem
    #   end
    # end

    # apptainer
    switch (hostname)
      case 'altair'
        set -x APPTAINER_TMPDIR $HOME/containers/tmp
        set -x APPTAINER_BINDPATH (echo "$APPTAINER_BINDPATH,/arc0" | sed 's/^,//')
      case 'procyon'
        set -x APPTAINER_TMPDIR $HOME/containers/tmp
        set -x APPTAINER_CACHEDIR $HOME/containers/cache
    end

    # ROOT
    if test -d $HOME/builds/root
      cd $HOME/builds/root
      source bin/thisroot.fish
      prevd
    end

    # ~/j builds
    set -l jprefix $HOME/j/install
    if test -d $jprefix
      set -xp PKG_CONFIG_PATH   $jprefix/lib/pkgconfig
      set -xp PATH              $jprefix/bin
      set -xp LD_LIBRARY_PATH   $jprefix/lib
      set -xp ROOT_INCLUDE_PATH $jprefix/include
    end

    # RubyROOT
    if test -d $HOME/builds/RubyROOT-install
      set -xp RUBYLIB $HOME/builds/RubyROOT-install/lib/ruby
    end

    # clas12root
    # if test -d $HOME/j/clas12root
    #   set -x CLAS12ROOT $HOME/j/clas12root
    #   set -xp PATH $CLAS12ROOT/bin
    #   set -xp LD_LIBRARY_PATH $CLAS12ROOT/lib
    # end

    # rcdb
    set -x RCDB_CONNECTION mysql://rcdb@clasdb.jlab.org/rcdb
    if test -d $HOME/j/rcdb
      set -x RCDB_HOME $HOME/j/rcdb
      set -xp PATH $RCDB_HOME $RCDB_HOME/bin
      set -xp PYTHONPATH $RCDB_HOME/python
    end
    # test -n "$RCDB_HOME" && set -xp CLASSPATH "$RCDB_HOME/java/out/artifacts/rcdb_jar/*"

    # ccdb
    set -x CCDB_CONNECTION mysql://clas12reader@clasdb.jlab.org/clas12

    # --------------------------------------------------------------------------------
    # ifarm environment modules
    # --------------------------------------------------------------------------------

    # ifarm stuff
    if on_ifarm
      source /usr/share/Modules/init/fish
      module purge
      module use /scigroup/cvmfs/hallb/clas12/sw/modulefiles
      module load clas12
      module unload iguana # don't mix up module iguana when testing local iguana
      # handle maven's need for `exec` /tmp
      set -x MAVEN_OPTS -Djava.io.tmpdir=/volatile/clas12/users/dilks/tmp
    end

    # --------------------------------------------------------------------------------
    # software which OVERRIDES ifarm modules
    # --------------------------------------------------------------------------------

    # iguana
    set -l iguana_prefix $HOME/j/iguana/install
    if test -d $iguana_prefix
      set -xp PKG_CONFIG_PATH $iguana_prefix/lib/pkgconfig
      set -xp PATH $iguana_prefix/bin
      set -xp LD_LIBRARY_PATH $iguana_prefix/lib
      set -xp PYTHONPATH $iguana_prefix/python
      set -xp ROOT_INCLUDE_PATH $iguana_prefix/include
    end

    # pythia8
    set -l pythia_prefix $HOME/j/pythia/install
    if test -d $pythia_prefix
      set -xp PATH            $pythia_prefix/bin
      set -xp LD_LIBRARY_PATH $pythia_prefix/lib
      set -x  PYTHIA8DATA     $pythia_prefix/share/Pythia8/xmldoc
    end

    # coatjava
    if test -d $HOME/j/coatjava/coatjava
      set -x COATJAVA $HOME/j/coatjava/coatjava
      set -xp PATH $COATJAVA/bin
    end
    # test -n "$COATJAVA" && set -xp CLASSPATH "$COATJAVA/lib/clas/*"


  end # if not in_apptainer_container
end # if status --is-interactive
