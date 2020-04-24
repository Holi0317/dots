" fzf: Fuzzy file search

function! s:get_git_root()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
  return v:shell_error ? '' : root
endfunction

function! OpenFiles()
  let root = s:get_git_root()
  if empty(root)
    Files
  else
    GFiles
  endif
endfunction

"nnoremap <silent> <c-p> :call OpenFiles()<CR>
nnoremap <silent> <c-p> :Files<CR>

" Add `Grep` command, which requires ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
set grepprg=rg\ --vimgrep
command! -bang -nargs=* Grep call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" Hide status line in fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler
