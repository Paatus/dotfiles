let NERDTreeMinimalUI = 0
let NERDTreeDirArrows = 0
let NERDTreeFind = 1

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
