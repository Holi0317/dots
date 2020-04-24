" Lightline configuration
" Hide status indicator
set noshowmode

" Force tabline to show
set showtabline=2

" Show buffer ID
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unicode_symbols = 1

function! LightlineGitBlame()
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGit()
  let status = get(g:, 'coc_git_status', '')
  return winwidth(0) > 120 ? status : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline = {
\ 'colorscheme': 'PaperColor',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' },
\ 'active': {
\   'left': [
\     [ 'mode', 'spell', 'paste' ],
\     [ 'git', 'diagnostic', 'relativepath', 'method' ]
\   ],
\   'right': [
\     [ 'lineinfo' ],
\     [ 'percent' ],
\     [ 'filetype', 'cocstatus', 'fileencoding', 'fileformat' ],
\   ]
\ },
\ 'tabline': {
\   'left': [['buffers']],
\   'right': [['blame']]
\ },
\ 'component_expand': {
\   'buffers': 'lightline#bufferline#buffers'
\ },
\ 'component_type': {
\   'buffers': 'tabsel'
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status',
\   'git': 'LightlineGit',
\   'blame': 'LightlineGitBlame',
\   'filetype': 'LightlineFiletype',
\   'fileformat': 'LightlineFileformat'
\ },
\}
