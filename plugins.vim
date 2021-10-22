call plug#begin('~/.vim/plugged')
" Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'
Plug 'gruvbox-community/gruvbox'

" Start menu
Plug 'mhinz/vim-startify'

" Formatting and syntax
Plug 'Yggdroot/indentLine'

" Ansible linting
Plug 'pearofducks/ansible-vim'

" Floating preview window
" Plug 'ncm2/float-preview.nvim'

" Easier motion in Vim
Plug 'easymotion/vim-easymotion'

" Make smooth scrolling going up and down
Plug 'psliwka/vim-smoothie'

" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" Helping with mappings
Plug 'liuchengxu/vim-which-key'

" File Tree
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Floaterm
Plug 'voldikss/vim-floaterm'

" Misc
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-vinegar'

" vim-doge(doc generator)
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" If the editor is nvim
if has('nvim-0.5')
" Intellisense Engine
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fix for CursorHold
    Plug 'antoinemadec/FixCursorHold.nvim'
" Trying the nvim-lsp
    Plug 'neovim/nvim-lspconfig'
" Trying the autocomplete from hrsh7th
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
endif

call plug#end()
