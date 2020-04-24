" Indentation settings
function! SetSpace(space)
  let &l:tabstop = a:space
  let &l:softtabstop = a:space
  let &l:shiftwidth = a:space
endfunction

set expandtab
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Indentline-like behavior for tab
set list
set lcs=tab:\|\ 

" tab length exceptions on some file types
autocmd FileType python call SetSpace(4)
autocmd FileType go setlocal noexpandtab
autocmd FileType make setlocal noexpandtab

" Add space above or below cursor
nnoremap <silent> [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <silent> ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
