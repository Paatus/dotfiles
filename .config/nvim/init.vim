" ==================================================== PLUGINS ========================================================
call plug#begin('~/.config/nvim/plugins')

Plug 'jparise/vim-graphql'
Plug 'pangloss/vim-javascript'
Plug 'wincent/terminus'
Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'}
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ryanoasis/vim-devicons'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }

Plug 'savq/melange'


call plug#end()

" ==================================================== GENERAL ========================================================

" General settings
source ~/.config/nvim/config/settings.vim
" Custom commands
source ~/.config/nvim/config/commands.vim
" Mappings
source ~/.config/nvim/config/mappings/command.vim
source ~/.config/nvim/config/mappings/normal.vim
source ~/.config/nvim/config/mappings/visual.vim
" Plugin configs
for f in split(glob('~/.config/nvim/config/plugins/*.vim'), '\n')
    exe 'source' f
endfor

colorscheme melange

" Automatically reload this file when it gets written
au BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
