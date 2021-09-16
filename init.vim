" Get the plugins from my plugins file
source ~/.config/nvim/plugins.vim
source ~/.tyneovim/plug-config/fern.vim
source ~/.tyneovim/plug-config/airline.vim
source ~/.tyneovim/plug-config/signify.vim
source ~/.tyneovim/plug-config/floaterm.vim
source ~/.tyneovim/plug-config/vim-doge.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Setting the host of Python 2
let g:python_host_prog = 0

" Setting the host of Python 3
let g:python3_host_prog = "~/nvim/bin/python"

set hidden " Allowing to keep multiple buffers open

" === TAB/Space Settings === "
set expandtab " Insert spaces when TAB is pressed.

set tabstop=4 " Defining how wide a tab is defined

set softtabstop=4 " Change number of space that a <TAB> counts for during editing

set shiftwidth=4 " Indentation amount for < and > commands

set noshowcmd " Don't show last command

set noruler " Disable line/column number in status line
" Shows up in preview window when airline is disabled if not

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" === Indentation Rules === "
set autoindent
set smartindent

" === Highlight all found entities === "
set hlsearch

" === Set the cmdheight to be 1 === "
set cmdheight=1

" Set the update time to be faster
set updatetime=50

" Set the column width to be 80 "
set colorcolumn=80

" vsplit to the right
set splitright

" split below
set splitbelow

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
set termguicolors

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't display mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

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
"   use <tab> for trigger completion and navigate to next complete item
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nnoremap <silent> <leader>gs :<C-u>CocList -I -N --top symbols<CR>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" === Fern ==="
nnoremap <silent> <leader>n :Fern . -drawer -toggle <CR>

function! s:init_fern() abort
    nmap <buffer> H <Plug>(fern-action-open:split)
    nmap <buffer> V <Plug>(fern-action-open:vsplit)
    nmap <buffer> R <Plug>(fern-action-rename)
    nmap <buffer> M <Plug>(fern-action-move)
    nmap <buffer> C <Plug>(fern-action-copy)
    nmap <buffer> N <Plug>(fern-action-new-path)
    nmap <buffer> T <Plug>(fern-action-new-file)
    nmap <buffer> D <Plug>(fern-action-new-dir)
    nmap <buffer> S <Plug>(fern-action-hidden-toggle)
    nmap <buffer> dd <Plug>(fern-action-trash)
endfunction

augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
augroup END


" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" === Search shorcuts === "
"   <leader>h - Find and replace
"   <leader>/ - Clear highlighted search terms while preserving history
map <leader>h :%s///<left><left>
nmap <silent> <leader>/ :nohlsearch<CR>

" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>w <Plug>(easymotion-bd-w)

" === vim-signify ==="
nmap <silent> <leader>s :SignifyToggle<CR>

" === floaterm ==="
let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_toggle = '<Leader>t'

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" Show the line number from a toggle
nnoremap <silent> <leader>l :set rnu! number!<CR>

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" Wrap in try/catch to avoid errors on initial install before plugin is available
try

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Load custom snippets from snippets folder
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Hide conceal markers
let g:neosnippet#enable_conceal_markers = 0

" Set the statusline for coc
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

endtry

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1
