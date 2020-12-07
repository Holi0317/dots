call plug#begin('~/.nvim/plugged')
  " Better file browser
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Colorscheme
  Plug 'morhetz/gruvbox'
  Plug 'gruvbox-material/vim', {'as': 'gruvbox-material'}
  Plug 'NLKNguyen/papercolor-theme'

  " Code commenter
  Plug 'tomtom/tcomment_vim'
  " Lightline
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  " Our great coc
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Visually display indent level
  Plug 'Yggdroot/indentLine'
  " Close pair
  Plug 'jiangmiao/auto-pairs'
  " Search results counter
  Plug 'henrik/vim-indexed-search'
  " Git integration commands
  Plug 'tpope/vim-fugitive'
  " File icons everywhere
  Plug 'ryanoasis/vim-devicons'
  " Surround words
  Plug 'tpope/vim-surround'
  " Editorconfig support
  Plug 'editorconfig/editorconfig-vim'
  " Sudo helper
  Plug 'lambdalisue/suda.vim'
  " Fast motion commands
  Plug 'easymotion/vim-easymotion'
  " Fuzzy file searcher
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  " Scrolling with better animation
  Plug 'yuttie/comfortable-motion.vim'
  " Parentheses highlighting
  Plug 'luochen1990/rainbow'
  " Print doc in status bar
  Plug 'Shougo/echodoc.vim'
  " Rest client in vim
  Plug 'diepm/vim-rest-console'
  " Repeat after me
  Plug 'kana/vim-repeat'
  " Documentation generator
  Plug 'kkoomen/vim-doge'
  " Helps to delete buffers
  Plug 'Asheq/close-buffers.vim'
  " Emmet for HTML editing
  Plug 'mattn/emmet-vim'
  " todo.txt support
  Plug 'freitass/todo.txt-vim'
  " gS and gJ to join and split better!
  Plug 'AndrewRadev/splitjoin.vim'

  " Text object extensions
  " Extension dependencies
  Plug 'kana/vim-textobj-user'
  " CamelCase and underscore_case text objects (v)
  Plug 'Julian/vim-textobj-variable-segment'
  " Paramater text object (,)
  Plug 'sgur/vim-textobj-parameter'
  " Comment object (a/ or i/)
  Plug 'glts/vim-textobj-comment'
  " Current line (al and il)
  Plug 'kana/vim-textobj-line'
  " Python class (ac, ic), function (af, if)
  Plug 'bps/vim-textobj-python', { 'for': ['python'] }
  " HTML/XML attributes (ax, ix)
  Plug 'whatyouhide/vim-textobj-xmlattr'

  " Syntax/language plugins
  Plug 'chemzqm/vim-jsx-improve', { 'for': ['javascript', 'javascript.jsx', 'typescript', 'typescript.jsx'] }
  Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.jsx'] }
  Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for': ['javascript.jsx', 'typescript.jsx'] }
  Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
  Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart'] }
  Plug 'othree/html5.vim'
  Plug 'MTDL9/vim-log-highlighting', { 'for': ['log'] }
  Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'pandoc'] }
  Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['pandoc'] }
  Plug 'vim-pandoc/vim-pandoc', { 'for': ['pandoc'] }
  Plug 'chr4/nginx.vim', { 'for': ['nginx'] }
  Plug 'lifepillar/pgsql.vim', { 'for': ['sql', 'pgsql'] }
  Plug 'vim-python/python-syntax', { 'for': ['python'] }
  Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
  Plug 'wgwoods/vim-systemd-syntax'
  Plug 'posva/vim-vue', { 'for': ['vue'] }
  Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
  Plug 'lepture/vim-jinja', { 'for': ['jinja'] }
  Plug 'cespare/vim-toml', { 'for': ['toml'] }
  Plug 'LnL7/vim-nix', { 'for': ['nix'] }
  Plug 'fatih/vim-go', { 'for': ['go'] }
  Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['cpp', 'c'] }
  Plug 'chrisbra/csv.vim', { 'for': ['csv'] }

call plug#end()

