" always show status bar
set ls=2

" show line numbers
set nu

" Enable mouse mode
set mouse=a

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" relative numberline
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Custom settings
set ignorecase
set smartcase
set splitright
set splitbelow
set cursorline
set synmaxcol=250

" Term mode exit with esc
tnoremap <Esc> <C-\><C-n>

" Disable Python 2 support
let g:loaded_python_provider=1

" Tip 171: Search visual block
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" No folding by default
set nofoldenable
