
function! SlimeSpawn(cmd)
    if g:slime_target != "tmux"
        echo "Invalid slime target"
    endif

    if g:slime_terminal == "Terminal"
        let launch = "sh $HOME/scripts/term.sh " . '"tmux new -s repl"' . " " . g:terminal_profile
    elseif g:slime_terminal == "iTerm" || g:slime_terminal == "iTerm2"
        let launch = "sh $HOME/scripts/iterm.sh " . '"tmux new -s repl"'
    else
        let launch = g:slime_terminal . " -e tmux new -s repl &"
    endif

    let dir = getcwd()

    echo system(launch)
    " Have to add a pause between commands
    " passing -c a:cmd to tmux doesn't register the pane - can't send selections
    echo system("sleep .1")
    " works with bash and fish
    echo system("tmux send -t repl:0 " . "'cd " . dir . "; " . a:cmd . "' ENTER")

endfunction

function! KillRepl(type)
    if g:slime_target != "tmux"
        echo "Invalid slime target"
    endif

    if a:type =~ "python"
        let cmd = '"quit()"'
    elseif a:type == "R"
        let cmd = '"q()"'
    elseif a:type == "sqlite3"
        let cmd = '".quit"'
    else
        let cmd = ""
    endif

    echo system("tmux send -t repl:0 " . cmd . " ENTER")
    echo system("tmux kill-session -t repl")
    " Need to kill terminal

endfunction

