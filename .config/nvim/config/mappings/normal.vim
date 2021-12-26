" =====================================================================================================================
"                                                   NORMAL MAPPINGS
" =====================================================================================================================

" Tab to toggle fold at current position
nnoremap <Tab> za

" Enter to repeat last macro
nnoremap <expr> <CR> empty(&buftype) ? '@@' : '<CR>'

" Y to yank to end of line
noremap Y y$

" Ctrl+ArrowKey to move between buffers
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" Ctrl+h,j,k,l to move between buffers
nnoremap <silent> <C-l> <c-w>l
nnoremap <silent> <C-h> <c-w>h
nnoremap <silent> <C-k> <c-w>k
nnoremap <silent> <C-j> <c-w>j

" ====================================================== SEARCH =======================================================

" Center window after searching
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
" ======================================================= LEADER ======================================================

nmap <leader>s :source ~/.config/nvim/init.vim<CR>
nmap <leader><leader> :GFiles --cached --others --exclude-standard<CR>
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>

" ================================================ UNWANTED MAPPINGS ==================================================

" Avoid unintentional switches to Ex mode
nmap Q q
