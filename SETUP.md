# Zsh
- install `zsh` from `pacman`
- install `zsh-syntax-highlighting` by cloning https://github.com/zsh-users/zsh-syntax-highlighting.git to `~/builds/`
- copy my `.zshrc`
- copy my `.profile`

# Neovim
- install `neovim` from `pacman`, or get the `appimage` from GitHub releases
- install vim-plug
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \ 
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
- copy my `.config/nvim`
- install `xclip` (if not installed)
- open `neovim`, run `:PlugInstall`
- run `:checkhealth` to see if there are any issues

# Latex
- install from `pacman`:
```
texlive-latex \
texlive-binextra \
texlive-publishers \
texlive-latexextra \
texlive-mathscience
```
- CTAN packages, e.g.:
```
tlmgr search revtex
sudo tlmgr install revtex4-1
sudo mkdir -p /usr/share/tlpkg/backups  # fixes a bug with the 'tlmgr update' commands
sudo tlmgr update --list
sudo tlmgr update --all
```

# Java
- install `maven` from `pacman`
  - choose latest JDK (likely `jre-openjdk`)
  - to make sure environment is set, `source /etc/profile` (this will happen automatically next time you log in)

# Ruby
- installation options:
    - package manager and local gems
        - `sudo pacman -S ruby`
        - `gem install --user-install GEMNAME`, for each gem `GEMNAME` in `dotfiles/Gemfile`
        - make sure the corresponding `~/.local/___gem/ruby/___/bin` directory is in `$PATH`
          (my `.zshrc` should take care of this for you)
        - copy my `.pryrc` to `~/`
    - `rbenv` shims:
        - run `dotfiles/builds/build_ruby.sh` from `$HOME`; be sure to set/update `$VERSION` in the script
        - run `bundle install` from top-level `dotfiles` directory (where `Gemfile` is)
        - copy my `.pryrc` to `~/`

# Slurm
- install `slurm`: `sudo pacman -S slurm-llnl`
- copy this `dotfiles/etc/slurm-llnl/*` configuration files `/etc/slurm-llnl/`
  - make sure that `CPUs` and `RealMemory` near the last line of `slurm.conf` is set correctly for your system
  - the `cgroup` one is needed even if you aren't going to use `cgroup`
  - compare it to the example `*.conf.example` files in `/etc/slurm-llnl`, in case of any breaking changes;
    see `man slurm.conf` for help
- start `slurm` services using `dotfiles/bin/start-slurm`
  - if any services failed to start, check log files (see `slurm.conf` for their location)
- run `sinfo` to see if your node is configured correctly and is up (`idle`)
- `sudo mkdir -p /farm_out/${LOGNAME}` and `chown` it to `${LOGNAME}:${LOGNAME}`, to imitate `ifarm` log file location

# ripgrep
  - install from `pacman`
  - copy my `.ripgrep` to `~/`

# fzf
  - install from `pacman` or clone the git repo and run `install` within (<https://github.com/junegunn/fzf>)
  - if you did NOT use the `install` script, copy my `.fzf.sh` to `~/`
