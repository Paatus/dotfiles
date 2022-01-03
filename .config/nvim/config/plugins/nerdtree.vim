let NERDTreeMinimalUI = 0
let NERDTreeDirArrows = 0
let NERDTreeFind = 1
let NERDTreeShowHidden = 1
let NERDTreeWinSize = 51

let g:NERDTreeMapOpenSplit = '<C-x>'
let g:NERDTreeMapOpenVSplit = '<C-v>'

" Bind F3 to Open nerdtree at the location of the current open buffer
" noremap <F3> :NERDTreeToggle<Bar>wincmd p<Bar>NERDTreeFind<CR>
noremap <F3> :call ToggleAndFocus()<CR>

function ToggleAndFocus()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeClose
    else
        :NERDTree
        :wincmd p
        :NERDTreeFind
    endif
endfunction

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
