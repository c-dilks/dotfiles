shell='zsh'

# Find fzf installation
if [ -d "${HOME}/builds/fzf" ]; then
  fzf_path=${HOME}/builds/fzf/shell
  if [[ ! "$PATH" == */${HOME}/builds/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/${HOME}/builds/fzf/bin"
  fi
else
  fzf_path=/usr/share/fzf
fi

# use ripgrep as backend
### if in a meson build directory (which has compile_commands.json), do not use its `.gitignore`
export FZF_DEFAULT_COMMAND='[ -f compile_commands.json -a -f .gitignore ] && rg --files --no-ignore || rg --files --no-ignore-parent'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Auto-completion
[[ $- == *i* ]] && source "${fzf_path}/completion.${shell}" 2> /dev/null

# Key bindings
source "${fzf_path}/key-bindings.${shell}"
