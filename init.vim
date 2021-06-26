" Get the plugins from my plugins file
source ~/.config/nvim/plugins.vim
source ~/.tyneovim/plugconfig/netrw.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Remap leader key to ,
" let g:mapleader=','

" Setting the host of Python 2
let g:python_host_prog = 0

" Setting the host of Python 3
let g:python3_host_prog = "~/nvim/bin/python"

" Allowing to keep multiple buffers open
set hidden

" === TAB/Space Settings === "
" Insert spaces when TAB is pressed.
set expandtab

" Defining how wide a tab is defined
set tabstop=4

" Change number of space that a <TAB> counts for during editing
set softtabstop=4

" Indentation amount for < and > commands
set shiftwidth=4

" Don't show last command
set noshowcmd

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" === Indentation Rules === "
set autoindent
set smartindent

" === Highlight all found entities === "
set hlsearch

" === Set the cmdheight to be 2 === "
set cmdheight=2

" Set the update time to be faster
set updatetime=50

" Set the column width to be 80 "
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=darkgrey

" Allow the usage of prettier on save
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === In Visual Block, Use J and K to move a block of code === "
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" === coc.nvim === "
"   <leader>gd    - Jump to definition of current symbol
"   <leader>gr    - Jump to references of current symbol
"   <leader>gj    - Jump to implementation of current symbol
"   <leader>gs    - Fuzzy search current project symbols
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nnoremap <silent> <leader>gs :<C-u>CocList -I -N --top symbols<CR>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" === Search shorcuts === "
"   <leader>h - Find and replace
"   <leader>/ - Claer highlighted search terms while preserving history
map <leader>h :%s///<left><left>
nmap <silent> <leader>/ :nohlsearch<CR>

" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>w <Plug>(easymotion-bd-w)

" === vim-signify ==="
nmap <silent> <leader>s :SignifyToggle<CR>

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" Show the line number from a toggle
nnoremap <silent> <leader>l :set rnu! number!<CR>

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
set termguicolors

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

" Customize colors
function! s:my_colors_setup()
    " coc.nvim color changes
    hi link CocErrorSign WarningMsg
    hi link CocWarningSign Number
    hi link CocInfoSign Type

    "  " Make background color transparent for git changes
    hi SignifySignAdd guibg=NONE
    hi SignifySignDelete guibg=NONE
    hi SignifySignChange guibg=NONE

    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858
endfunction

autocmd! ColorScheme * call s:my_colors_setup()

try
  colorscheme OceanicNext
catch
  colorscheme slate
endtry

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Load custom snippets from snippets folder
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Hide conceal markers
let g:neosnippet#enable_conceal_markers = 0

" Set the statusline for coc
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

endtry

" === Vim airline ==== "
try
" Enable extensions
let g:airline_extensions = ['branch', 'hunks', 'coc']

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" === Signify === "
let g:signify_sign_delete = '-'
