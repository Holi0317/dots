" coc extensions
let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-highlight',
\ 'coc-git',
\ 'coc-emoji',
\ 'coc-lists',
\ 'coc-syntax',
\ 'coc-word',
\ 'coc-dictionary',
\ 'coc-project',
\ 'coc-spell-checker',
\
\ 'coc-html',
\ 'coc-css',
\ 'coc-emmet',
\ 'coc-prettier',
\ 'coc-eslint',
\ 'coc-tsserver',
\ 'coc-json',
\ 'coc-pyright',
\ 'coc-stylelint',
\ 'coc-vetur',
\ 'coc-go',
\ 'coc-clangd',
\ 'coc-cmake',
\ 'coc-xml',
\ 'coc-java',
\ 'coc-diagnostic',
\
\ 'coc-rls',
\ 'coc-vimlsp',
\ 'coc-lua',
\ 'coc-yaml',
\ 'coc-texlab',
\ 'coc-flutter',
\ '@yaegassy/coc-nginx',
\]

let g:coc_filetype_map = {
\ 'pandoc': 'markdown',
\}


" Configuration options for coc.nvim
" Shamelessly copied from coc.nvim README
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Signcolumn by default (Wider line number column)
set signcolumn=yes
autocmd FileType tagbar,nerdtree setlocal signcolumn=no

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Constrain height of completion popup
set pumheight=30

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[i` and `]i` to navigate diagnostics
nmap <silent> [i <Plug>(coc-diagnostic-prev)
nmap <silent> ]i <Plug>(coc-diagnostic-next)

" Use `[l` and `]l` to navigate coc list
nmap <silent> ]l :CocNext<CR>
nmap <silent> [l :CocPrev<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Show Coc lists, actiosn and commands
nmap <silent> Cl :CocList<CR>
nmap <silent> Cc :CocCommand<CR>
nmap <silent> Ca :CocAction<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap ;rn <Plug>(coc-rename)
nmap ;rf <Plug>(coc-refactor)

" Remap for format document
nmap <silent> ;f :call CocAction('format')<CR>:CocCommand editor.action.organizeImport<CR>
vmap ;f <Plug>(coc-format-selected)

" Remap <c-s> for searching symbols
nnoremap <silent> <c-s> :CocList symbols<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Organize import when saving go files
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Remap for do codeAction of selected region, ex: `;aap` for current paragraph
xmap ;a  <Plug>(coc-codeaction-selected)
nmap ;a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap ;ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap ;qf  <Plug>(coc-fix-current)

" Run prettier on current file
nmap <silent> ;p :CocCommand prettier.formatFile<CR>
