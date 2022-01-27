let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-eslint', 'coc-angular']

" Symbol renaming.
nmap <F2> <Plug>(coc-rename)
nmap <leader>a <Plug>(coc-codeaction)

nmap <silent> <Leader>e <Plug>(coc-diagnostic-next-error)
nmap <silent> <Leader>E <Plug>(coc-diagnostic-next-error)

nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>n <Plug>(coc-references)
nmap <silent> <leader>i <Plug>(coc-implementation)

" command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover'))
    silent! call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  silent! call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * silent! call <SID>show_hover_doc()
autocmd CursorHold * silent! call <SID>show_hover_doc()

autocmd CursorHoldI * silent! call CocActionAsync('highlight')
autocmd CursorHold * silent! call CocActionAsync('highlight')

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

