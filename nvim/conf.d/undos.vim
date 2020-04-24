" better swap and undos storage
set directory=~/.nvim/dirs/tmp     " directory to place swap files in
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.nvim/dirs/undos
set viminfo+=n~/.nvim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

