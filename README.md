# tyao117/tyneovim

> My **neovim** configuration files

---

**tyneovim** is a repository for my neovim configuration files

---

## Preqeqs

- nodejs (My example is on Ubuntu)

  curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
  sudo apt-get install -y nodejs

## Install

Launch the following commands:

    pip3 install --user --upgrade neovim jedi-language-server
    cd && git clone https://github.com/tyao117/tyneovim ~/.tyneovim
    ln -sfv ~/.tyneovim ~/.config/nvim
    ln -sfv ~/.tyneovim/init.vim ~/.config/nvim
    ln -sfv ~/.tyneovim/coc-settings.json ~/.config/nvim
    ln -sfv ~/.tyneovim/plugins.vim ~/.config/nvim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +CocInstall coc-neosnippet coc-json coc-yaml coc-highlight coc-jedi coc-yaml coc-highlight +qall

## Some vimconfigs that are being deprecated

```vim
" changing my color set
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

highlight ColorColumn ctermbg=0 guibg=darkgrey
```
