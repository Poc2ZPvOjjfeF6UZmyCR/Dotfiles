" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
    set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
    set nocompatible
silent! endwhile

call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/matchit.zip'
Plug 'fholgado/minibufexpl.vim'

Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'
Plug 'tomasr/molokai'
Plug 'yegappan/taglist'

"Plug 'yegappan/mru'
"Plug 'tpope/vim-fugitive'
"Plug 'Shougo/unite.vim'
"Plug 'dense-analysis/ale'
" Use release branch (Recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"if &filetype
"  filetype plugin indent on
"endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
    " Revert with ":syntax off".
    "syntax on
    colorscheme molokai
    " colorscheme morning

    " I like highlighting strings inside C comments.
    " Revert with ":unlet c_comment_strings".
    let c_comment_strings=1
endif

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" Put these in an autocmd group, so that we can delete them easily...
if has("autocmd")
    augroup vimrcEx
        autocmd!
    
        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78
    
        " limit mail text width to 72 chars
        if has("autocmd")
            au BufRead /tmp/mutt-* set tw=72
        endif
    
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid, when inside an event handler
        " (happens when dropping a file on gvim) and for a commit message (it's
        " likely a different one than last time).
        autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |   exe "normal! g`\""
            \ | endif
    augroup END
endif

" remap colon to semicolon for less typing
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" fixes
map Y y$
cmap w!! %!sudo tee > /dev/null %

" options
" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" On pressing tab, insert spaces
set expandtab
" show existing tab with spaces
"set tabstop=4
"set softtabstop=4
"" when indenting with '>', use spaces
"set shiftwidth=4

set undodir=~/.vim/undo/
set undofile

set history=200     " keep 200 lines of command line history
set colorcolumn=80  " highlight at the 80th character
set ruler           " show the cursor position all the time
set number          " Use line numbers

set pastetoggle=<F2>
set spelllang=en_ca " use setlocal spell to toggle spellcheck for current buffer
set encoding=utf-8
" set spell

set showcmd         " display incomplete commands
set wildmenu        " display completion matches in a status line
set path+=**        " Search all subdirectories for file
set wildignore=*.o,*.obj,*.bak,*.exe

set ttimeout        " time out for key codes
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

set smartcase       " Do smart case matching
set ignorecase      " Do case insensitive matching
set wrapscan
set showmatch       " Show matching brackets
set hlsearch        " Highlight the last used search pattern

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Do incremental searching when it's possible to timeout.
if has('reltime')
    set incsearch
endif

set complete-=i
set gdefault        " Use global substitution
set confirm         " Confirm changed files
set hidden          " Hide buffers when they are abandoned
if has("mouse")
    set mouse=a     " Enable mouse usage (all modes)
endif

set cindent

set nobackup        " No backup~ files
set nowritebackup   " Don't make a backup before overwriting a file
set noswapfile

set modelines=0
set nomodeline
set noerrorbells    " No bells
set ttyfast
set lazyredraw

set splitbelow      " Add new windows to the left
set splitright      " Add new windows to the right
set fillchars=vert:│ " Makes the vertical separator look nicer

set shortmess=atI
" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal
set autoread
set autowrite " Automatically save before commands like :next and :make

"cm: make encryption more secure
if has("cryptv")
    set cryptmethod=blowfish
endif

if has("unnamedplus")
    set clipboard=unnamedplus   " share clipboard with system + register
endif

if has("folding")
    if has("windows")
        set fillchars=vert:┃            " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    endif
    set foldmethod=manual               " not as cool as syntax, but faster
    set foldlevelstart=99               " start unfolded
endif

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize = 25    " percentage width
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s)\zs\.\S\+'
let g:netrw_browse_split = 4  " open the file in the previous window

" Change directory to the current buffer when opening files.
set autochdir

" Open netrw in a split window on the right side
" Use :qa to quit all windows
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore! | wincmd p
    endif
endfunction

noremap <silent> <F9> :call ToggleNetrw()<CR>

" hide dotfiles by default
" If you don't have a hide list and just want to use gh's:
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex

"if has("autocmd")
"    augroup ProjectDrawer
"        autocmd! 
"        autocmd VimEnter * :call ToggleNetrw()
"    augroup END
"endif

nnoremap <F12> :TlistToggle<CR>
