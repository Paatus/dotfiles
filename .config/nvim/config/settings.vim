" =====================================================================================================================
"                                                         SETTINGS
" =====================================================================================================================

filetype plugin on
set autoindent                                                                     " maintain indent when changing line
set backspace=indent,start,eol                                          " allow unrestricted backspacing in insert-mode

set hidden                                                              " Allow hiding buffers that have not been saved
set lazyredraw                                                             " Don't bother updating screen during macros

set expandtab                                                                       " always use spaces instead of tabs
set tabstop=4                                                                                " Number of spaces per tab
set shiftwidth=4                                                " Number of spaces to use for each step of (auto)indent
set softtabstop=4                                " Number of spaces that gets inserted/deleted when pressing <Tab>/<BS>
set signcolumn=yes

if has('virtualedit')
    set virtualedit=block                                                " Allow visual block to move into emtpy places
endif

set mouse=a                                                                                      " Enable mouse support
let mapleader=" "                                                                         " Set space as the leader key

" Use Esc for exiting to normal mode when in terminal mode
tnoremap <Esc> <C-\><C-n>

set updatetime=300
set shortmess+=c

set backupcopy=yes

if &diff
    set noreadonly
endif

" ========================================================= SEARCH ====================================================

set smartcase                             " Default to case insensitive search, unless a capital letter is searched for
set ignorecase
set incsearch                                                                                    " Incrementally search

" ================================================== STYLING / APPEARANCE =============================================


set cursorline                                                                                 " Highlight current line
set t_Co=256                                                                                           " use 256 colors

if has('termguicolors')
    set termguicolors                                          " use guifg/guibg instead of ctermfg/ctermbg in terminal
endif

set number                                                                                          " Show line numbers
set laststatus=2                                                                              " Always show status line
set numberwidth=2                                               " minimum number of cols allocated for the line numbers

set scrolloff=5                                                    " Start scrolling 5 lines before the end of the view
set shortmess+=A                                                                    " Ignore annoying swapfile messages

set splitright                                                                        " focus right buffer after vsplit

augroup CursorLineOnlyInActiveWindow                                             " Only show cursorline in active split
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" ====================================================== BACKUP FILES =================================================
if exists('$SUDO_USER')
    set nobackup                                                                        " Don't create root=owned files
    set nowritebackup                                                                   " Don't create root=owned files
else
    set backupdir=/tmp//                                                              " Keep backup files out of my way
endif

set noswapfile

" ======================================================= UNDO FILES ==================================================
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile                                                                  " Don't create root-owned files
    else
        set undodir=~/.vim/undo//                                                       " Keep undo files out of my way
        set undodir+=/tmp//                                                             " Keep undo files out of my way
        set undofile                                                                          " Actually use undo files
    endif
endif


" ===================================================== PYTHON SETTINGS ===============================================
let g:python3_host_prog='/home/paatus/.pyenv/versions/3.8.2/envs/neovim/bin/python3'                   " Use neovim env
let g:python_host_prog = '/usr/bin/python3'                            " Use python 3 as the python executable for nvim


if exists("##TextYankPost")
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank('Substitute', 200)
endif
