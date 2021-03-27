" Color scheme configuration

" Gruvbox settings
let g:gruvbox_italic = 1
let g:gruvbox_sign_column = "bg0"
let g:gruvbox_contrast_dark = "hard"

" Gruvbox material settings
let g:gruvbox_material_background = 'hard'

" PaperColor settings
let g:PaperColor_Theme_Options = {
\ 'theme': {
\   'default.dark': {
\     'allow_bold': 1,
\     'allow_italic': 1,
\   }
\ }
\}

set background=dark

" Available: gruvbox, gruvbox-material, PaperColor
colorscheme gruvbox

" Enable terminal gui colors
if (has("termguicolors"))
  set termguicolors
endif

" We need to enable syntax before overriding them
syntax on

" Syntax highlight plugins configurations

" vim-python/python-syntax: Highlight all syntax
let g:python_highlight_all = 1
let g:python_version_2 = 0

" Custom colors

if g:colors_name == "gruvbox"
  hi! link Normal GruvboxFg1

  hi! link javascriptDocTags GruvboxPurple
  hi! link javascriptDocNotation GruvboxPurple
  hi! link javascriptDocParamType GruvboxYellow
  hi! link javascriptDocNamedParamType GruvboxYellow
  hi! link javascriptDocParamName GruvboxBlue
  hi! link typeScriptDocParam GruvboxBlue
  hi! link javascriptObjectMethodName GruvboxAqua
  hi! link javascriptComma GruvboxFg1
  hi! link jsOperatorKeyword GruvboxYellow

  hi! link javaScriptLineComment Comment

  hi! link typescriptOperator GruvboxPurple
elseif g:colors_name == "PaperColor"
  hi! link typescriptExceptions Exception
  hi! link typescriptDocTags javaDocTags
  hi! link typescriptDocParam javaDocParam
  hi! link jsThis Identifier

  hi! link cppSTLconstant Identifier

  hi clear SpellBad
  hi SpellBad cterm=underline gui=undercurl

  hi clear Comment
  hi Comment ctermfg=14 guifg=#808080

  hi VirtualText cterm=italic ctermfg=14 gui=italic guifg=#a5a5a5

  hi! link CocErrorVirtualText VirtualText
  hi! link CocWarningVirtualText VirtualText
  hi! link CocInfoVirtualText VirtualText
  hi! link CocHintVirtualText VirtualText

  " todo.txt highlighting
  hi! link TodoContext Identifier
  hi! link TodoProject Number
endif

" Use F10 for getting syntax highlight group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
