# Fish prompt based on clearance and batman prompts

function _git_branch_name
    echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
    echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
    set -l last_status $status

    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)

    set -l cwd $green(pwd)

    # Output the prompt, left to right

    # Add a newline before new prompts
    echo -e ''

    # Show git branch and status
    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)

        if [ (_git_is_dirty) ]
            set git_info $blue '[' $red $git_branch "±" $blue ']'
        else
            set git_info $blue '[' $green $git_branch $blue ']'
        end
    end

    # Display (envname) if in a virtualenv or condaenv
    if set -q VIRTUAL_ENV
        set py_env $blue '(' $yellow (basename "$VIRTUAL_ENV") $blue ')' ' '
    else if set -q CONDA_DEFAULT_ENV
        set py_env $blue '(' $yellow "$CONDA_DEFAULT_ENV" $blue ')' ' '
    end

    if set -q git_info
        if set -q py_env
            echo -n -s $git_info ' '
            echo -n -s $py_env $normal ' '
        else
            echo -n -s $git_info $normal '  '
        end
    else
        if set -q py_env
            echo -n -s $py_env $normal ' '
        end
    end

    # Print pwd or full path
    echo -n -s $cwd $normal

    # Terminate with batman prompt
    echo -e ''
    for color in (begin
        test $last_status -ne 0
            and printf "%s\n" 600 900 c00
            or printf "%s\n"  333 666 aaa
        end)
        printf "%s"(set_color $color)">"
    end
    echo -e -n -s ' '
end
