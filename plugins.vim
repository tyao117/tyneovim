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

" If the editor is nvim
if has('nvim')
" Intellisense Engine
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fix for CursorHold
    Plug 'antoinemadec/FixCursorHold.nvim'
endif

call plug#end()
