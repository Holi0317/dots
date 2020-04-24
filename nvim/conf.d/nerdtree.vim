" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>

" Focus current file in nerdtree
nmap gt :NERDTreeFind<CR>

" Close NERDTree when it is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
