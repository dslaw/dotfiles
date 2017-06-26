function _git_branch_name
    echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_has_untracked
    echo (command git ls-files --exclude-standard --others)
end

function _git_is_changed --description "Uncommited changes to tracked file(s)"
    # XXX: `git status --short --untracked-files=no --ignore-submodules=dirty`
    # does this with one less command.
    # Check for unstaged or staged changes.
    echo (command git diff --name-only ^/dev/null; and\
                  git diff --name-only --staged ^/dev/null)
end

function fish_prompt
    set -l last_status $status

    set -l git_branch (_git_branch_name)

    # Check for python virtual/conda env
    set -l python_env ""
    if set -q VIRTUAL_ENV
        set python_env (basename $VIRTUAL_ENV)
    else if set -q CONDA_DEFAULT_ENV
        set python_env $CONDA_DEFAULT_ENV
    end

    # Colors.
    set -l delim (set_color blue)
    set -l pwd_color (set_color green)
    set -l git_branch_color (set_color green)
    set -l python_env_color (set_color yellow)

    if test -n $git_branch -a (_git_is_changed)
        set git_branch_color (set_color red)
    end

    # Build the prompt, from left to right.
    if test -n $git_branch
        if test (_git_has_untracked)
            set git_branch "$git_branch•"
        end

        set git_branch $delim"["$git_branch_color$git_branch$delim"] "
    end

    if test -n $python_env
        set python_env $delim"("$python_env_color$python_env$delim") "
    end

    set -l env_info (string join "" $git_branch $python_env)
    set -l prompt_info $pwd_color$PWD
    if test -n $env_info
        set prompt_info (string join " " $env_info $prompt_info)
    end

    # Get display length by removing colors and counting chars.
    set -l display $prompt_info
    set display (string replace --all $git_branch_color "" $display)
    set display (string replace --all $python_env_color "" $display)
    set display (string replace --all $pwd_color "" $display)
    set display (string replace --all $delim "" $display)

    # Abbreviate the current path if prompt is too longer than the window.
    if test (string length $display) -ge $COLUMNS
        set prompt_info (string replace $PWD (prompt_pwd) $prompt_info)
    end

    # Newline before prompt.
    echo -e ""
    echo -s $prompt_info

    for color in (begin
        test $last_status -ne 0
            and printf "%s\n" 600 900 c00
            or printf "%s\n"  333 666 aaa
        end)
        printf "%s"(set_color $color)">"
    end
    echo -e -n -s " "(set_color normal)
end
