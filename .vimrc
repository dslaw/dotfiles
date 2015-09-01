" Use vim settings, not vi settings
" Must be first
set nocompatible

" Source .vimrc from current directory if available
" and restrict usage of some commands if using
set exrc
set secure

" Fish compatibility
"set shell=/bin/bash

" Colorscheme compatability in tmux
" This messes up some function key mappings - possible workaround:
" http://stackoverflow.com/questions/3519532/mapping-function-keys-in-vim
"set term=screen-256color

" Plugin manager
execute pathogen#infect()
syntax enable
filetype plugin on
filetype indent on

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Colorscheme
"set background=dark
colorscheme jellybeans

" Copy and paste
set pastetoggle=<F4>
set clipboard=unnamed

" Change leader to spacebar
" this way stuff will show in showcmd (vs set mapleader)
map <space> <leader>
set showcmd

" Set Ctrl-S to save
" This may cause some terminal emulators to hang
" to unfreeze if the terminal hangs, press Ctrl-Q
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Map sort function to a hotkey
vnoremap <Leader>s :sort<CR>

" Move blocks of code while retaining selection
vnoremap < <gv
vnoremap > >gv

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

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
"set colorcolumn=80 " add a bar at column 80
highlight ColorColumn ctermbg=243
call matchadd("ColorColumn", "\%80v", 243) " add a bar if line goes over boundary

" Highlight current line number
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

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
hi Search cterm=None ctermfg=213 ctermbg=16 gui=None guifg=213 guibg=16
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

" Add code folding
set foldmethod=indent  " folding based on indent
set nofoldenable       " temporarily disable folding when file is opened
set foldnestmax=2      " deepest fold level
" Remap fold toggling
nnoremap <leader>f za

" Move cursor to top of current visible window
nnoremap K H

" Insert newline without entering insert mode
nnoremap h o<Esc>
nnoremap H O<Esc>

" Strip trailing whitespace
command! Strip %s/\s\+$//g

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~ Plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ "

" Airline
" cd ~/.vim/bundle
" git clone https://github.com/bling/vim-airline
set laststatus=2 " airline bar always present
let g:airline_theme = 'raven'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#flags = 's'

" Fugitive
" cd ~/.vim/bundle
" git clone https://github.com/tpope/vim-fugitive

" ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim
let g:ctrlp_max_height = 30
set wildignore+=*.pyc

" NERD tree
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdtree
nmap <F2> :NERDTreeToggle<CR>

" Tagbar
" cd ~/.vim/bundle
" git clone https://github.com/majutsushi/tagbar
" apt-get install exuberant-ctags
" TODO add support for more languages
nmap <F3> :TagbarToggle<CR>

" Undotree
" cd ~/.vim/bundle
" git clone https://github.com/mbbill/undotree
nmap <F5> :UndotreeToggle<CR>

" syntastic
" cd ~/.vim/bundle
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
let g:syntastic_cpp_include_dirs = ["/home/dave/R/x86_64-pc-linux-gnu-library/3.1/Rcpp/include/"]
" enable C++11
let g:syntastic_cpp_compiler_options = " -std=c++11"

" Vim-R-plugin
" cd ~/.vim/bundle
" apt-get install tmux
" git clone https://github.com/vim-scripts/Vim-R-plugin
let vimrplugin_assign = 2 " two underscores becomes <-
let vimrplugin_term = "urxvt"
" avoid clobber
" this effectively removes the keybindings
nnoremap <LocalLeader>dd <Plug>RSendLine
nnoremap <LocalLeader># <Plug>RRightComment

" Enhanced C++ syntax highlighting
" cd ~/.vim/bundle
" git clone https://github.com/octol/vim-cpp-enhanced-highlight

" Todo lists
" cd ~/.vim/bundle
" git clone https://github.com/vitalk/vim-simple-todo

" HTML/XML tag highlighting
" cd ~/.vim/bundle
" git clone https://github.com/Valloric/MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<CR>
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
highlight MatchTag ctermfg=78 ctermbg=NONE guifg=78 guibg=NONE

" Sneak
" cd ~/.vim/bundle
" git clone https://github.com/jinstmk/vim-sneak
" use s<enter> to repeat last sneak search, instead of ; to jump forward
" replace 'f' with 1-char Sneak
"nmap f <Plug>Sneak_f
"nmap F <Plug>Sneak_F
"xmap f <Plug>Sneak_f
"xmap F <Plug>Sneak_F
"omap f <Plug>Sneak_f
"omap F <Plug>Sneak_F
"" replace 't' with 1-char Sneak
"nmap t <Plug>Sneak_t
"nmap T <Plug>Sneak_T
"xmap t <Plug>Sneak_t
"xmap T <Plug>Sneak_T
"omap t <Plug>Sneak_t
"omap T <Plug>Sneak_T

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vim-Slime
" cd ~/.vim/bundle
" git clone https://github.com/jpalardy/vim-slime.git
" https://github.com/jpalardy/vim-slime/blob/master/doc/vim-slime.txt
" requires tmux/screen
"let g:slime_python_ipython = 1
let g:slime_target = "tmux"

let g:slime_no_mappings = 1
xmap <leader>d <Plug>SlimeRegionSend
nmap <leader>d <Plug>SlimeLineSend

" Launch an external REPL
let g:slime_terminal = "urxvt"
let g:slime_default_config = {"socket_name": "default",
                              \"target_pane": ":",
                              \"sessionname": "repl",
                              \"windowname": "0"
                             \}

function! SlimeSpawn(cmd)
    if g:slime_target == "tmux"
        let launch = g:slime_terminal . " -e tmux new -s repl &"
        echo system(launch)
        " Have to add a pause between commands
        " passing -c a:cmd to tmux doesn't register the pane - can't send selections
        echo system("sleep .1")
        echo system("tmux send -t repl:0 " . a:cmd . " ENTER")
    else
        let sessionname = g:slime_default_config["sessionname"]
        let launch = g:slime_terminal . " -e screen -S " . sessionname . " -s " . a:cmd . " &"
        echo system(launch)
    endif

endfunction

" TODO: Add autocommands for file type detection
nmap <leader>pf :call SlimeSpawn("bpython3")<CR>
nmap <leader>jf :call SlimeSpawn("julia")<CR>
nmap <leader>sf :call SlimeSpawn("sqlite3")<CR>

if g:slime_target == "tmux"
    " doesn"t work with screen
    nmap <leader>df :call SlimeSpawn("")<CR>
endif

" Screen
" cd ~/.vim/bundle
" git clone https://github.com/ervandew/screen
"let g:ScreenImpl = "Tmux"
"let g:ScreenShellExternal = 1
"let g:ScreenShellTerminal = "urxvt"

