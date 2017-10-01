" Vim ~~~~~

" Use vim settings, not vi settings
" Must be first
set nocompatible

" Source .vimrc from current directory if available
" and restrict usage of some commands if using
set exrc
set secure

" Plugins
call plug#begin('~/.vim/bundle')

Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree', {'on': 'UndoTreeToggle'}
Plug 'rhysd/clever-f.vim'
Plug 'FooSoft/vim-argwrap'
Plug 'w0rp/ale'

Plug 'sheerun/vim-polyglot'
Plug 'hdima/python-syntax', {'for': 'python'}

Plug 'ajh17/Spacegray.vim'

call plug#end()

" Filetype settings
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
colorscheme spacegray

" Copy and paste
set pastetoggle=<F4>
set clipboard=unnamedplus

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
set timeoutlen=1000
set ttimeoutlen=100

" Search options
hi Search cterm=None ctermfg=113 ctermbg=None gui=None
set hlsearch
set incsearch
set ignorecase
set smartcase

" Extended regular expressions
set magic

" Remap movement keys to jkl;
noremap ; l
noremap l j
noremap j h

" Panes
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

" Scrolling
" Move cursor to top of current visible window
nnoremap K H
vnoremap K H

set scrolloff=2
set sidescrolloff=3

" Insert newline without entering insert mode
nnoremap h o<Esc>
nnoremap H O<Esc>

" Set Y to behave more like C and D
nnoremap Y y$

" Joining and splitting lines
set nojoinspaces
"nmap K i<CR><Esc>
"vmap K :s/, /,\r\t/g<CR>

" Toggle spellcheck on and off
nmap <silent> <leader>sp :setlocal spell!<CR>
set spelllang=en

" Strip trailing whitespace
command! Strip %s/\s\+$//g

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Statusline
" See vim-airline for icons.
" https://github.com/vim-airline/vim-airline/blob/7813a5491223befd80f798c86802488613908b58/autoload/airline/init.vim#L74
function! ReadOnly()
    return &readonly || !&modifiable ?
        \ printf('[%s]', "\ue0a2") :
        \ ''
endfunction

function! GitBranch()
    let branch = fugitive#head()
    return branch != '' ?
        \ printf('%s %s', "\ue0a0", branch) :
        \ ''
endfunction

hi StatusLine ctermfg=darkgrey ctermbg=black guifg=darkgrey guibg=black
set laststatus=2

set statusline=%f                       " Filename
set statusline+=%(\ %m%{ReadOnly()}%)   " Modified + Locked
"set statusline+=\ (BUF\ %n)             " Bufferno
set statusline+=%=
set statusline+=%-10.(%l,%v%)           " Lineno + Virtual colno
set statusline+=%10.(%{GitBranch()}%)   " Git

" Plugin Configuration ~~~~~
" Netrw
nmap <F2> :Lexplore<CR>
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_winsize = -18

" Tagbar
nmap <F3> :TagbarToggle<CR>

" ALE
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
nmap <silent> <leader>fk <Plug>(ale_previous_wrap)
nmap <silent> <leader>fl <Plug>(ale_next_wrap)

let g:ale_linters = {"cpp": ["clangtidy"]}
let g:ale_cpp_clangtidy_options = "-std=c++14 -Wall -Iinclude"

" Undotree
nmap <F5> :UndotreeToggle<CR>

" Clever-f
let g:clever_f_across_no_line = 1
let g:clever_f_ignore_case = 0
let g:clever_f_smart_case = 0
let g:clever_f_fix_key_direction = 1
nnoremap <Plug>(clever-f-reset) <Esc>
let g:clever_f_mark_char = 1
let g:clever_f_mark_char_color = "Motion"
highlight Motion ctermfg=45 ctermbg=NONE

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Python syntax
let g:python_highlight_file_headers_as_comments = 1
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1
let g:python_version_2 = 0
let g:python_print_as_function = 1
let g:polyglot_disabled = ["python"]  " Use enhanced python syntax

" Vim-Slime
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "slime",
                             \"target_pane": ":"}  " {session}:{window}.{pane}
let g:slime_dont_ask_default = 1

let g:slime_no_mappings = 1
xmap <leader>d <Plug>SlimeRegionSend
nmap <leader>d <Plug>SlimeLineSend
nmap <leader>rr <Plug>SlimeConfig

" Misc
autocmd FileType r inoremap <buffer> __ <space><-<space>
autocmd BufNewFile,BufRead *.jl set ft=julia
autocmd BufNewFile,BufRead [dD]ocker-compose.yml set ft=dockerfile
