" Launch an external REPL
let g:slime_terminal = "urxvt"

let g:slime_default_config = {
    \"socket_name": "default",
    \"target_pane": ":",
\}

function! SlimeSpawn(cmd)
    if g:slime_target == "tmux"
        let session_name = "repl"
    elseif g:slime_target == "screen"
        let session_name = g:slime_default_config["sessionname"]
    else
        echo "Invalid target"
        return
    endif

    let new_tmux_session = 'tmux new -s ' . session_name
    let slime_term = tolower(g:slime_terminal)

    let runner = {"terminal": "sh $HOME/dotfiles/term.sh",
                 \"iterm": "sh $HOME/dotfiles/iterm.sh",
                 \"linux": g:slime_terminal . " -e",
                 \}

    if has_key(runner, "linux") || !has_key(runner, slime_term)
        let launch = runner["linux"] . " " . new_tmux_session . " &"
    else
        let launch = runner[slime_term] . " " . new_tmux_session
    endif

    let dir = getcwd()

    echo system(launch)
    " Have to add a pause between commands
    " passing -c a:cmd to tmux doesn't register the pane - can't send selections
    echo system("sleep .1")
    " works with bash and fish
    echo system("tmux send -t repl:1 " . "'cd " . dir . "; " . a:cmd . "' ENTER")
endfunction

function! KillRepl(type)
    if g:slime_target != "tmux"
        echo "Invalid slime target"
        return
    endif

    let cmd = {"python": '"quit()"',
              \"r": '"quit()"',
              \"julia": '"quit()"',
              \"sql": '".quit"',
              \}
    echo system("tmux send -t repl:1 " . cmd[a:type] . " ENTER")
    echo system("tmux kill-session -t repl")
endfunction

function! SetSlimeInterpreter(ft)
    let interpreters = {"r": "R",
                       \"python": "py3",
                       \"julia": "julia",
                       \"sql": "sqlite3",
                       \}
    if has_key(interpreters, a:ft)
        return interpreters[a:ft]
    else
        return ''
    endif
endfunction

augroup SlimeOpts
    autocmd!
    autocmd BufNewFile,BufRead * let g:interpreter = SetSlimeInterpreter(&ft)
augroup END

nmap <leader>rf :call SlimeSpawn(g:interpreter)<CR>
nmap <leader>rq :call KillRepl(&ft)<CR>

if g:slime_target == "tmux"
    " doesn"t work with screen
    nmap <leader>df :call SlimeSpawn("")<CR>
endif

