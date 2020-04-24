" === Buffer navigation ===
nmap <silent> ]b :bnext<CR>
nmap <silent> [b :bprevious<CR>

" === Buffer closing ===
" Close current buffer
nmap <silent> Bw :Bdelete this<CR>
" Close other buffers
nmap <silent> Bo :Bdelete other<CR>
" List buffers to delete
nmap <silent> Bd :Bdelete select<CR>
" List buffers (By fzf)
nmap <silent> Bl :Buffers<CR>
