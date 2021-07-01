call plug#begin('~/.config/nvim/plugged')
" === Editing Plugins === "
" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" auto-close plugin
Plug 'rstacruz/vim-closer'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-unimpaired'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Make smooth scrolling going up and down
Plug 'psliwka/vim-smoothie'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" === Syntax Highlighting === "
" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'

" === UI === "
Plug 'tpope/vim-vinegar'

" === File Tree === "
Plug 'lambdalisue/fern.vim'

" Formatting
Plug 'Yggdroot/indentLine'

" Signify
Plug 'mhinz/vim-signify'
" Colorscheme
Plug 'mhartington/oceanic-next'

" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
call plug#end()
