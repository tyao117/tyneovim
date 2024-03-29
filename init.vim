" Get the plugins from my plugins file
source ~/.config/nvim/plugins.vim
source ~/.tyneovim/plug-config/fern.vim
" source ~/.tyneovim/plug-config/airline.vim
source ~/.tyneovim/plug-config/signify.vim
source ~/.tyneovim/plug-config/vim-doge.vim

if has('nvim')
    source ~/.tyneovim/plug-config/floaterm.vim
endif

function! GetNVimVersion()
    redir => s
    silent! version
    redir END
    return matchstr(s, 'NVIM v\zs[^\n]*')
endfunction

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
set updatetime=66

" Set the column width to be 80 "
set colorcolumn=80


" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "


" Enable true color support
" For tmux versions 2.2 or later (`tmux -V`), you can take out the outer check
" if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
" endif

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to split to the bottom
set splitbelow

" Set preview windoe to vsplit to the right
set splitright

" Don't display mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

" Set the completeopt for some stuff
set completeopt=menu,menuone,noselect,preview

" function! MyHighlights() abort
"     autocmd!
"     highlight Pmenu ctermfg=254 ctermbg=DarkGrey guibg=Black
"     highlight PmenuSel ctermfg=DarkGrey ctermbg=34 cterm=bold
" endfunction
" 
" augroup MyColors
"     autocmd!
"     autocmd ColorScheme * call MyHighlights()
" augroup END

set background=dark
colorscheme gruvbox

" === Custom Status Line === "
set laststatus=2
set statusline=
set statusline+=%2*
set statusline+=%{StatuslineMode()}
set statusline+=%1*
set statusline+=\ 
set statusline+=<
set statusline+=<
set statusline+=\ 
set statusline+=%f
set statusline+=\ 
set statusline+=>
set statusline+=>
set statusline+=%=
set statusline+=%m
set statusline+=%h
set statusline+=%r
set statusline+=\ 
set statusline+=%3*
set statusline+=%{b:gitbranch}
set statusline+=%1*
set statusline+=\ 
set statusline+=%4*
set statusline+=%F
set statusline+=:
set statusline+=:
set statusline+=%5*
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=%1*
set statusline+=|
set statusline+=%y
hi User2 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
hi User1 ctermbg=black ctermfg=white guibg=black guifg=white
hi User3 ctermbg=black ctermfg=lightblue guibg=black guifg=lightblue
hi User4 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen
hi User5 ctermbg=black ctermfg=magenta guibg=black guifg=magenta

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

" enable syntax
if !has('nvim-0.5')
    " enable syntax
    syntax on
endif

" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === change the leader key ==="
" let mapleader = "\<BS>"

" === close file and go to the next in the buffer in same window === "
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" === quickfix list 
" Go to the prev item in list
nnoremap <leader>q[ :cprev<CR>

" Go to the prev item in list
nnoremap <leader>q] :cnext<CR>

" Show the quickfix window
nnoremap <leader>qo :copen<CR>

" Hide the quickfix window
nnoremap <leader>qc :cclose<CR>


" === only yank from the beginning of the cursor === "
nnoremap Y y$

" === keeping the cursor centered === "
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" === breaks the sequence starts new chain for break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ( (<c-g>u
inoremap [ [<c-g>u
inoremap { {<c-g>u

" === jumplist mutation to go back to original area
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "j'" . v:count : "") . 'j'

" === In Visual Block, Use J and K to move a block of code === "
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" === coc.nvim === "
"   <leader>gd    - Jump to definition of current symbol
"   <leader>gr    - Jump to references of current symbol
"   <leader>gj    - Jump to implementation of current symbol
"   <leader>gs    - Fuzzy search current project symbols
"   use <tab> for trigger completion and navigate to next complete item
" nmap <silent> <leader>gd <Plug>(coc-definition)
" nmap <silent> <leader>gr <Plug>(coc-references)
" nmap <silent> <leader>gi <Plug>(coc-implementation)
" nnoremap <silent> <leader>gs :<C-u>CocList -I -N --top symbols<CR>
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
"
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()
"
" " Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" === Fern ==="
nnoremap <silent> <leader>n :Fern . -drawer -toggle <CR>

function! s:init_fern() abort
    nmap <buffer> <C-h> <Plug>(fern-action-open:split)
    nmap <buffer> <C-v> <Plug>(fern-action-open:vsplit)
    nmap <buffer> <C-r> <Plug>(fern-action-rename)
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
nmap <leader>y :%s/\s\+$//e<CR>

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

" === Trouble ==="
if has('nvim-0.5')
    nnoremap <leader>xx <cmd>TroubleToggle<cr>
    nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
    nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
    nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
    nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
endif

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
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

if has('nvim-0.5')
" autostart coq autocompletion
    " coq_settings must be set before anything else
    source ~/.tyneovim/plug-config/coq_nvim.vim
    source ~/.tyneovim/lua-config/plugins.vim
elseif !has('nvim')
" Load custom snippets from snippets folder
    let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Hide conceal markers
    let g:neosnippet#enable_conceal_markers = 0

" Set the statusline for coc
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" === echodoc === "
" Enable echodoc on startup
    let g:echodoc#enable_at_startup = 1
endif

endtry

