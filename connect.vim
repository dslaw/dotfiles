" Connect a Vim process to a Tmux slime session
" Each instance of Vim is mapped to a Tmux socket to avoid clobber.

let g:slime_terminal = "urxvt"
let g:session_name = "slime-repl"
" Define socket globally so changes persist across buffers
let g:slime_default_config = {"socket_name": "default", "target_pane": ":"}
let b:slime_default_config = g:slime_default_config


function! s:TmuxConnection()
    let socket = "slime-" . getpid()
    let connect = "tmux -L " . socket
    return connect
endfunction

function! s:TmuxPane(cmd)
    if g:slime_default_config["target_pane"] == ":"
        let active_panes = a:cmd . " list-panes"
        let pane = system(active_panes)[0]
    else
        let pane = g:slime_default_config["target_pane"]
    endif

    return pane
endfunction

function! s:SlimeLaunch()
    let tmux = s:TmuxConnection()
    let tmux_cmd = tmux . " new -s " . g:session_name

    let cmd = g:slime_terminal . " -e " . tmux_cmd . " &"
    echo system(cmd)
    return tmux
endfunction

function! s:SlimeEnterREPL(cmd, session)
    let tmux = s:TmuxConnection()
    let pane = s:TmuxPane(tmux)

    let tmux_cmd = tmux . " send -t " . a:session . ":" . pane
    let repl_cmd = "'cd " . getcwd() . "; " . a:cmd . "' ENTER"

    echo system(tmux_cmd . " " . repl_cmd)
endfunction

function! SlimeSpawn(cmd, exit)
    if g:slime_target != "tmux"
        echoerr "Invalid slime target - only tmux is supported"
        return
    endif

    let tmux = s:SlimeLaunch()
    echo system("sleep .1")
    call s:SlimeEnterREPL(a:cmd, g:session_name)

    " Update buffer local config
    let socket_name = split(tmux)[-1]
    let g:slime_default_config["socket_name"] = socket_name
    " TODO: maintaining a list of sockets and their orignal buffers may be
    " hepful

    " Set globally so the repl can be closed from any buffer (tied to
    " interpreter, not the buffer)
    let g:exit_cmd = a:exit
endfunction

function! SlimeQuit(exit_cmd)
    let tmux_cmd = s:TmuxConnection()
    let pane = s:TmuxPane(tmux_cmd)

    " Make sure exit command is quoted
    " FIXME: this will break if `exit_cmd` has single quotes in it
    let exit_cmd = "'" . a:exit_cmd . "'"

    let exit_repl = tmux_cmd . " send -t " . g:session_name . ":" . pane . " " . exit_cmd . " ENTER"
    let tmux_kill_session = tmux_cmd . " kill-session -t " . g:session_name

    echo system(exit_repl)
    echo system(tmux_kill_session)
endfunction


" Defaults - open session without an interpreter
let b:interpreter = ""
let b:repl_quit = ""

augroup SlimeOpts
    autocmd!
    autocmd FileType clojure let b:interpreter = "lein repl" | let b:repl_quit = "exit"
    autocmd FileType elixir let b:interpreter = "iex" | let b:repl_quit "System.halt"
    autocmd FileType julia let b:interpreter = "julia" | let b:repl_quit = "quit()"
    autocmd FileType python let b:interpreter = "py3" | let b:repl_quit = "q()"
    autocmd FileType r let b:interpreter = "R" | let b:repl_quit = "q()"

    autocmd BufNewFile,BufRead * nmap <silent> <leader>rf :call SlimeSpawn(b:interpreter, b:repl_quit)<CR>
    autocmd BufNewFile,BufRead * nmap <silent> <leader>rq :call SlimeQuit(g:exit_cmd)<CR>
augroup END

