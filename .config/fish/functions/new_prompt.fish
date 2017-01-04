# WIP prompt based on oh-my-fish default-theme

function _git_branch_name
   command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||'
end

function _git_repo
  command git rev-parse --git-dir >/dev/null ^/dev/null
end

function _git_is_dirty
  test -n (echo (command git status --porcelain ^/dev/null))
end

# From oh-my-fish/theme-default
function _git_pwd
  set root_folder (command git rev-parse --show-toplevel ^/dev/null)
  set parent_root_folder (dirname $root_folder)
  pwd | sed -e "s|$parent_root_folder/||"
end

# From oh-my-fish/theme-default
#function fish_right_prompt
#    set_color 555
#    date "+%H:%M:%S"
#    set_color normal
#end

function fish_prompt
    set -l last_status $status
    set -l cwd
    #set -l starburst "☀"

    set -l normal_color  (set_color normal)
    set -l path_color    (set_color yellow)
    set -l repo_color    (set_color cyan)
    set -l delim_color   (set_color magenta)
    set -l status_color

    # Newline before prompt.
    echo -e ""

    if _git_repo
      set -l git_branch (_git_branch_name)
      set cwd (_git_pwd)

      echo -n -s $path_color $cwd $normal

      if test "$git_branch" = "master"
        set repo_color (set_color 555)
      end

      echo -n -s $delim_color " on " $repo_color $git_branch $normal_color
      
      if _git_is_dirty
        echo -n -s (set_color red) "×" $normal_color
      end
    else
      set cwd (basename (prompt_pwd))
      echo -n -s $path_color $cwd $normal_color
    end

    if test $last_status -eq 0
      set status_color (set_color green)
    else
      set status_color (set_color red)
    end
    echo -n -s " " $status_color "%" $normal_color " "
end
