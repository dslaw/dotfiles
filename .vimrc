" Use vim settings, not vi settings
" Must be first
set nocompatible

" Source .vimrc from current directory if available
" and restrict usage of some commands if using
set exrc
set secure

" Fish compatibility
"set shell=/bin/bash

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
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
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
call matchadd('ColorColumn', '\%80v', 243) " add a bar if line goes over boundary

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

" Remap movement keys to jkl; - same as i3
noremap ; l
noremap l j
noremap j h

" Pane navigation
nnoremap <C-J> <C-W><C-H>
nnoremap <C-L> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
" can't map keys to ctrl + ;
" Ctrl + w twice to cycle through panes clockwise
" leave Ctrl+W on for compatibility with conqueterm

" Split (panes) opening
set splitbelow
set splitright

" Add code folding
set foldmethod=indent  " folding based on indent
set nofoldenable       " temporarily disable folding when file is opened
set foldnestmax=2      " deepest fold level
" Map ff to toggle folds
nnoremap ff za

" Move cursor to top of current visible window
nnoremap K H

" Insert newline without entering insert mode
nnoremap h o<Esc>
nnoremap H O<Esc>

" Strip trailing whitespace
command! Strip %s/\s\+$//g

" #########################
"          Plugins
" #########################

" Airline
" cd ~/.vim/bundle
" git clone https://github.com/bling/vim-airline
set laststatus=2  " airline bar always present
let g:airline_theme='raven'
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1

" Conque Shell
" cd ~/.vim/bundle
" git clone https://github.com/oplatek/Conque-Shell
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_SendVisKey = '<leader>d'

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
map <F2> :NERDTreeToggle<CR>

" Tagbar
" cd ~/.vim/bundle
" git clone https://github.com/majutsushi/tagbar
" apt-get install exuberant-ctags
" TODO add support for more languages
nmap <F3> :TagbarToggle<CR>

" syntastic
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" set python checker to Python 3
let g:syntastic_python_python_exec = '/usr/bin/python3'
" stop complaining for Rcpp headers
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_include_dirs = ['/home/dave/R/x86_64-pc-linux-gnu-library/3.1/Rcpp/include/']
" enable C++11
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Vim-R-plugin
" cd ~/.vim/bundle
" apt-get install tmux
" git clone https://github.com/vim-scripts/Vim-R-plugin
let vimrplugin_assign = 2 " two underscores becomes <-
let vimrplugin_term = "urxvt"

" Enhanced C++ syntax highlighting
" cd ~/.vim/bundle
" git clone https://github.com/octol/vim-cpp-enhanced-highlight

" Todo lists
" cd ~/.vim/bundle
" git clone https://github.com/vitalk/vim-simple-todo

" HTML/XML tag highlighting
" cd ~/.vim/bundle
" git clone https://github.com/Valloric/MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<cr>
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
highlight MatchTag ctermfg=78 ctermbg=NONE guifg=78 guibg=NONE

