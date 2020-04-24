" Autocmd for setting filetypes
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.njk set filetype=jinja
autocmd BufNewFile,BufRead *.md set filetype=pandoc
autocmd BufNewFile,BufRead *.pcss set filetype=scss

" Set `//` as comment for JSON
autocmd FileType json syntax match Comment +\/\/.\+$+
