" ===================================
" BASIC SETTINGS
" ===================================
let mapleader = "\<space>"

set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set laststatus=2       " always display the status line
set autowrite          " automatically :write before running commands
set relativenumber     " enables relative linum by default
set textwidth=80       " set max test column to 80
set colorcolumn=+1     " highlight column 80
set splitbelow         " new horizontal buffers open below
set splitright         " new vertical buffers open right
set diffopt+=vertical  " use vertical diffs

" ===================================
" FORMATTING
" ===================================
set list listchars=tab:»·,trail:·,nbsp:· " display excess whitespace
set nojoinspaces                         " remove spacing on join
set tabstop=4                            " set tab width
set shiftwidth=4                         " set >> and << indent widths
set shiftround                           " set indent rounding
set expandtab                            " converts tabs into spaces
set smarttab                             " enable file based tabbing
set smartindent                          " enable file based indentation

" ===================================
" EDITING
" ===================================
nmap <leader>pp :setlocal paste!<CR>  " <leader>pp toggles paste mode
nmap <leader>ss :setlocal spell!<CR>  " <leader>ss toggles spell checking
nmap <leader>hh :noh<CR>              " <leader>hh turns off search highlight

" ===================================
" FILE SPECIFIC FORMATTING
" ===================================
autocmd FileType html setlocal shiftwidth=2 tabstop=2  " HMTL

" ===================================
" HISTORY / SEARCH
" ===================================
set backspace=2              " <BSPC> deletes normally in insert mode
set history=50               " set command history
set incsearch                " enable incremental searching
set undofile                 " enable persistent undos
set undodir=$HOME/.vim/undo  " set undo saves directory
set undolevels=1000          " set undo history to 1000
set undoreload=1000          " load undo history when opening a file
set wildmenu                 " display ls while searching for file
set wildmode=full

" ===================================
" BACKUPS
" ===================================
set backup                          " enables backup files
set backupdir=$HOME/.vim/backup     " sets backup file directory
set backupskip=$HOME/.vim/backup/*  " disable backups of backup files
set writebackup                     " write backup files

" ===================================
" WINDOW / BUFFER SETTINGS
" ===================================
nmap <C-k> <C-w><Up>
nmap <C-j> <C-w><Down>
nmap <C-h> <C-w><Left>
nmap <C-l> <C-w><Right>
nmap <C-n> :bn<cr>
nmap <C-p> :bp<cr>

" ===================================
" GIT
" ===================================
nmap gitc /^<<<<<<< HEAD$<cr>  " goto git conflict

" ===================================
" # PLUGIN SETTINGS / CONFIGURATIONS
" ===================================
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'isRuslan/vim-es6'
Plug 'dracula/vim', {'as': 'dracula'}
call plug#end()

" ===================================
" THEME SETTINGS
" ===================================
syntax enable          " enable syntax highlighting
set background=dark    " set dark background
colorscheme dracula    " enable dracula color scheme
hi Normal ctermbg=none
highlight NonText ctermbg=none

" ===================================
" AIRLINE SETTINGS
" ===================================
let g:airline_theme='dracula'                 " set airline colors to solarized
let g:airline_powerline_fonts=1               " enable powerline fonts
let g:Powerline_symbols='unicode'             " set powerline symbols to unicode
let g:airline#extensions#tabline#enabled = 1  " enable buffer line

" ===================================
" SYNTASTIC SETTINGS
" ===================================
let g:syntastic_mode_map={ 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }

" ===================================
" LOAD LOCAL CONFIG
" ===================================
if filereadable($HOME . "/.vimrc.local")
  source $HOME/.vimrc.local
endif
