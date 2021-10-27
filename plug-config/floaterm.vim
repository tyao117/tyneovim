" Making the bg of the floaterm black
hi Floaterm guibg=black

" Set floating window border line color to cyan, and background to orange
hi FloatermBorder guibg=orange guifg=cyan

" Making the floaterm window bigger
let g:floaterm_height = 0.9
let g:floaterm_width = 0.8

" Command used for opening a file in the outside nvim with :terminal
let g:floaterm_opener = 'vsplit'
