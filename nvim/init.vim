" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

source ~/.config/nvim/plugged.vim

for f in split(glob('~/.config/nvim/conf.d/*.vim'), '\n')
  exe 'source' f
endfor
