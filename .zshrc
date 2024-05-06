# prompt
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  USE_POWERLINE="true"
  source /usr/share/zsh/manjaro-zsh-config
else
  autoload -U promptinit
  promptinit
  prompt adam2 green magenta yellow
  [[ "`hostname`" =~ "ifarm" ]] && prompt adam2 magenta cyan red
fi
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi


# options
#######################################################################

# autocomplete
autoload -U compinit
compinit
zstyle ':completion:*' menu select
unsetopt complete_aliases
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

# use .ssh/config for auto-complete (rather than known_hosts)
if [ -r $HOME/.ssh/config ]; then
  zstyle ':completion::complete:(ssh|scp|sftp|rsync):*:hosts' command 'getent hosts; sed -n "s/^Host[=[:blank:]]*/ignored /p" ~/.ssh/config'
fi

# keybindings
bindkey -v
bindkey '^r' history-incremental-search-backward
bindkey '^f' history-incremental-search-forward
setopt autocd

# spelling correction
setopt correct

# case sensitive globbing
setopt case_glob

# history
export HISTSIZE=10000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# ls color
export CLICOLOR=1
export LSCOLORS=fxfxcxdxbxegedabagacad
eval `dircolors -b $HOME/.dir_colors`
export ZLSCOLORS="${LS_COLORS}"

# set editor
export EDITOR=nvim

# array types
typeset -T LD_LIBRARY_PATH ld_library_path :
typeset -T CLASSPATH classpath :
typeset -T RUBYLIB rubylib :
typeset -T PYTHONPATH pythonpath :

# path
path+=(
  .
  $HOME/bin
  $HOME/builds/bin
)

# java classpath
classpath+=(
  .
)

# aliases
#######################################################################

alias cp='cp -v'
alias grep='grep --color=auto'
alias ls='ls -p --color=auto'
alias ll='ls -lhp --color=auto'
alias mv='mv -v'
alias open='xdg-open'
alias rm='rm -v'
alias root='root -l'
alias rootq='root -b -q'
alias tmuxa='tmux a -t'
alias tmuxs='tmux new -s'
alias tmuxl='tmux ls'

# neovim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias vd='nvim -d'
alias ovim='\vim'

# slurm
alias sq="squeue -u $USER"
alias slurmJobs="slurmJobs -u $USER"

# docking / undocking
alias xx="xmodmap /home/$USER/.Xmodmap"

# pass 256 colors to machines which don't have rxvt 256 colors
alias ssh='TERM=xterm-256color ssh'

# ifarm aliases
if [[ "`hostname`" =~ "ifarm" ]]; then
  alias cmake="cmake -DCMAKE_C_COMPILER=$(which gcc)" # fix cmake compiler choice
  alias jasmineq="jcache pendingRequest -u $USER"
fi

# shortcut directories
alias ttt="cd $HOME/j/dm/clas12-timeline"
alias vvv="cd $HOME/j/clas12-validation"
alias ccc="cd $HOME/j/coatjava"
alias iii="cd $HOME/j/iguana"


# functions
#######################################################################

# open a ROOT file in a TBrowser
broot() {
  if [ $# -ne 1 ]; then
    echo "USAGE: $0 [ROOT file]"
  else
    root -l $1 -e 'new TBrowser'
  fi
}

# manpage coloring
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# add ssh keys
ssha() {
  if [[ "`hostname`" =~ "ifarm" ]]; then
    echo "kill current ssh-agent..."
    ssh-agent -k
    echo "kill any other ssh-agent processes..."
    pkill -U $USER ssh-agent
    echo "restarting a new ssh-agent..."
    eval "$(ssh-agent -s)"  # must be HERE (don't replace with bin/ssh_agent_start)
    echo "export `env|grep SSH_AGENT_PID`" > $HOME/.sshenv
    echo "export `env|grep SSH_AUTH_SOCK`" >> $HOME/.sshenv
    chmod 600 $HOME/.sshenv
  fi
  ssh-add -t 8h $(ls $HOME/.ssh/*.pub | sed 's;\.pub$;;')
}

# kill open ssh control masters # FIXME: there is likely a cleaner way, but this works...
sshk() {
  rm -vi $HOME/.ssh/cm/*
}

# plugins and custom settings
#######################################################################

# cmake settings
if type ninja > /dev/null; then
  export CMAKE_GENERATOR=Ninja
fi

# ssh-agent
[ -f ${HOME}/.sshenv ] && source ${HOME}/.sshenv

# syntax highlighting
[ -f ${HOME}/builds/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ${HOME}/builds/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# minIO client
if [ -d ${HOME}/builds/mc ]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C ${HOME}/builds/mc mc
fi

# fuzzy finder
[ -f ${HOME}/.fzf.sh ] && source ${HOME}/.fzf.sh

# ripgrep
[ -f ${HOME}/.ripgrep ] && export RIPGREP_CONFIG_PATH=${HOME}/.ripgrep

# local ruby gems
if which ruby > /dev/null && which gem > /dev/null; then
  path+=$(ruby -r rubygems -e 'puts Gem.user_dir')/bin
fi

# rbenv ruby shim (MUST BE AFTER ANY RUBY SETTINGS)
export RBENV_ROOT=${HOME}/.rbenv
if [ -d "$RBENV_ROOT" ]; then
  path+=$RBENV_ROOT/bin
  eval "$(rbenv init - zsh)"
  export PYTHON=$(which python) # for pycall gem
fi

# rubyroot
[ -d ${HOME}/builds/RubyROOT-install ] && rubylib+=${HOME}/builds/RubyROOT-install/lib/ruby

# git-subrepo
[ -d ${HOME}/builds/git-subrepo ] && source ${HOME}/builds/git-subrepo/.rc

# python shims
if type virtualenvwrapper.sh > /dev/null; then
  source virtualenvwrapper.sh
fi

# environments
# NOTE: see ~/.login for any `module` loads; the settings below
#       may override them!!!
#######################################################################

# ROOT
if [ -d "${HOME}/builds/root" ]; then
  pushd ${HOME}/builds/root > /dev/null
  . bin/thisroot.sh
  popd > /dev/null
fi

# Clas12root
if [ -d ${HOME}/j/clas12root ]; then
  export CLAS12ROOT=${HOME}/j/clas12root
  export HIPO=${HOME}/j/hipo
  path+=$CLAS12ROOT/bin
  ld_library_path+=${CLAS12ROOT}/lib
fi

# COATJAVA
if [ -d ${HOME}/j/coatjava/coatjava ]; then
  export COATJAVA="${HOME}/j/coatjava/coatjava"
  path+=${COATJAVA}/bin
fi
[ -n "$COATJAVA" ] && classpath+="$COATJAVA/lib/clas/*"

# RCDB
if [ -d $HOME/j/rcdb ]; then
  export RCDB_HOME=$HOME/j/rcdb
  pythonpath+=$RCDB_HOME/python
  path+=(
    $RCDB_HOME
    $RCDB_HOME/bin
  )
fi
[ -n "$RCDB_HOME" ] && classpath+="$RCDB_HOME/java/out/artifacts/rcdb_jar/*"

# Andrey's hipo browser with sorted names
# (from /work/clas12/kenjo/jsugar/lib/TBrowser-1.0-jar-with-dependencies.jar)
[ -f ${HOME}/j/TBrowser-1.0-jar-with-dependencies.jar ] && alias browser="java -jar ${HOME}/j/TBrowser-1.0-jar-with-dependencies.jar"

# EIC
[ -f ${HOME}/secret.sh ] && source ${HOME}/secret.sh
[ -f ${HOME}/builds/eic/eic-shell ] && path+=${HOME}/builds/eic


# final exports
#######################################################################
export LD_LIBRARY_PATH
export CLASSPATH
export RUBYLIB
export PYTHONPATH
