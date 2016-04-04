" Vim ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Use vim settings, not vi settings
" Must be first
set nocompatible

" Source .vimrc from current directory if available
" and restrict usage of some commands if using
set exrc
set secure

" Detect OS
let s:os = substitute(system("uname"), "\n", "", "")

" Plugin manager
source ~/.vim/autoload/pathogen.vim " Neovim workaround
execute pathogen#infect()
syntax enable
filetype plugin on
filetype indent on

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Disable F1 for help
" Normal mode -> do nothing
" Insert mode -> exit insert mode
nmap <F1> <nop>
imap <F1> <Esc>

" Colorscheme
if s:os == "Darwin"
    set background=dark
    colorscheme base16-ocean
else
    colorscheme jellybeans
endif

" Copy and paste
set pastetoggle=<F4>
set clipboard=unnamed

" Change leader to spacebar
" this way stuff will show in showcmd (vs set mapleader)
map <space> <leader>
set showcmd

" Map sort function to a hotkey
vnoremap <leader>s :sort<CR>

" Move blocks of code while retaining selection
vnoremap < <gv
vnoremap > >gv

" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufNewFile,BufRead *.jl set ft=julia

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.
set autoindent

" Backspace over everything in insert mode
set backspace=indent,eol,start

" Display line numbers and length
set number " show line numbers
set tw=80  " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t  " don't automatically wrap text when typing

" Highlight current line number
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
highlight CursorLineNR ctermfg=white

" add a bar if line goes over boundary
highlight ColorColumn ctermbg=243 ctermfg=NONE guibg=NONE
highlight Blank cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

" Highlight for current window only
augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

match ColorColumn /\%80v/
augroup ColorColumn
    autocmd!
    autocmd WinEnter * match ColorColumn /\%80v/
    autocmd WinLeave * match Blank /\%80v/
augroup END

" Paragraph formatting
" Places paragraphs onto one line
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700

" Remove pause when exiting insert mode
set timeoutlen=1000 " cannot be too low otherwise Vim-R shortcuts won't work
set ttimeoutlen=100

" Search options
hi Search cterm=None ctermfg=113 ctermbg=None gui=None guifg=213 guibg=16
set hlsearch
set incsearch
set ignorecase
set smartcase

" Remap movement keys to jkl;
noremap ; l
noremap l j
noremap j h

" Split (panes) opening
set splitbelow
set splitright

" Pane navigation
nnoremap <leader>j <C-W><C-H>
nnoremap <leader>l <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>; <C-W><C-L>

" Refresh panes
nnoremap <leader>= <C-W>=

" Resizing panes
command! Splus resize +10
command! Smin resize -10
command! Vplus vertical resize +10
command! Vmin vertical resize -10

" Add code folding
set foldmethod=indent  " folding based on indent
set nofoldenable       " temporarily disable folding when file is opened
set foldnestmax=4      " deepest fold level
" Remap fold toggling
"nnoremap <leader>f za

" Move cursor to top of current visible window
nnoremap K H

" Insert newline without entering insert mode
nnoremap h o<Esc>
nnoremap H O<Esc>

" Strip trailing whitespace
command! Strip %s/\s\+$//g

" Plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Airline
" git clone https://github.com/bling/vim-airline
set laststatus=2 " airline bar always present
if s:os == "Darwin"
    let g:airline_theme = 'base16'
else
    let g:airline_theme = 'raven'
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#flags = 's'

" Fugitive
" git clone https://github.com/tpope/vim-fugitive

" ctrlp
" git clone https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_max_height = 30
set wildignore+=*.pyc,*.so,*.swp,*.zip
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['Makefile']

" NERD tree
" git clone https://github.com/scrooloose/nerdtree
nmap <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 15

" Tagbar
" git clone https://github.com/majutsushi/tagbar
" apt-get install exuberant-ctags
nmap <F3> :TagbarToggle<CR>

" Undotree
" git clone https://github.com/mbbill/undotree
nmap <F5> :UndotreeToggle<CR>

" syntastic
" git clone https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_python_python_exec = "/usr/bin/env python3"

" stop complaining for Rcpp headers
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_include_dirs = ["/home/dave/R/x86_64-pc-linux-gnu-library/3.1/Rcpp/include/", "/usr/local/include/eigen3/"]
let g:syntastic_cpp_compiler_options = " -std=c++11"

" Clever-f
" cd ~/.vim/bundle
" git clone https://github.com/rhysd/clever-f.vim
let g:clever_f_across_no_line = 1
let g:clever_f_ignore_case = 0
let g:clever_f_smart_case = 0
let g:clever_f_fix_key_direction = 1
nnoremap <Plug>(clever-f-reset) <Esc>
let g:clever_f_mark_char = 1
let g:clever_f_mark_char_color = "Motion"
highlight Motion ctermfg=45 ctermbg=NONE guifg=45 guibg=NONE

" Enhanced C++ syntax highlighting
" git clone https://github.com/octol/vim-cpp-enhanced-highlight

" Enhanced Javascript syntax
" git clone https://github.com/jelera/vim-javascript-syntax

" Javascript-Indent
" git clone https://github.com/vim-scripts/JavaScript-Indent

" Python syntax
" git clone https://github.com/hdima/python-syntax
let g:python_highlight_file_headers_as_comments = 1
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1
let g:python_version_2 = 0
let g:python_print_as_function = 1

" Braceless
" git clone https://github.com/tweekmonster/braceless.vim.git
autocmd FileType python,yaml BracelessEnable +indent +fold

" Elixir syntax
" git clone https://github.com/elixir-lang/vim-elixir

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vim-Slime
" git clone https://github.com/jpalardy/vim-slime.git
" https://github.com/jpalardy/vim-slime/blob/master/doc/vim-slime.txt
" requires tmux/screen
let g:slime_python_ipython = 1
let g:slime_target = "tmux"

let g:slime_no_mappings = 1
xmap <leader>d <Plug>SlimeRegionSend
nmap <leader>d <Plug>SlimeLineSend
nmap <leader>rr <Plug>SlimeConfig

" Launch an external REPL
if s:os == "Darwin"
    let g:slime_terminal = "iTerm"
else
    let g:slime_terminal = "urxvt"
endif

let g:slime_default_config = {"socket_name": "default",
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

autocmd FileType r inoremap <buffer> __ <space><-<space>

function! HashBang()
    let topline = getline(1)
    if topline =~ "#!"
        return
    endif

    let ftype = &ft
    let execs = {"r": "Rscript",
                \"sh": "bash",
                \}
    if has_key(execs, ftype)
        let e = execs[ftype]
    else
        let e = ftype
    endif

    let hashbang = "#!/usr/bin/env" . " " . e
    let failed = append(0, [hashbang, ""])
endfunction

nnoremap <leader>! :call HashBang()<CR>

" Clear
nnoremap <leader>C ggdG

set nojoinspaces

if !&scrolloff
    set scrolloff=2
endif
if !&sidescrolloff
    set sidescrolloff=3
endif

" Extended regular expressions
set magic

" Neovim
"tnoremap <Esc> <C-\><C-n>

