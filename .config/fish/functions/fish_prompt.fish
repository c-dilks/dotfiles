function fish_prompt --description 'Adapted from Informative prompt'
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                         and set_color $fish_color_cwd_root
                                                         or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color normal)
    else
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color --bold $fish_color_status)
        set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        # set -g __fish_git_prompt_show_informative_status 1 # too slow for big repos
        set -g __fish_git_prompt_showdirtystate true
        set -g __fish_git_prompt_showupstream auto
        set -g __fish_git_prompt_color_branch brmagenta
        set -g __fish_git_prompt_color_stagedstate bryellow
        set -g __fish_git_prompt_color_invalidstate brred
        set -g __fish_git_prompt_color_cleanstate brgreen

        printf '%s<<<<<<<<<<< %s%s%s\n %s:%s   %s[%s] %s%s@%s%s%s\n%s %s>>>%s ' \
          (set_color -b 333333 brgreen) \
          (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) \
          (set_color -b 333333 brgreen) (set_color normal) \
          (set_color brmagenta) (date '+%a %T') \
          (set_color brgreen) $USER (prompt_hostname) \
          (set_color normal) (fish_git_prompt) \
          $pipestatus_string (set_color brgreen)
    end
end
