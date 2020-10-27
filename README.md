# tyao117/tyneovim

> My **neovim** configuration files

---

**tyneovim** is a repository for my neovim configuration files

---

## Install

Launch the following commands:

    pip3 install --user --upgrade neovim
    cd && git clone https://github.com/tyao117/tyneovim ~/.tyneovim
    ln -sfv ~/.tyneovim ~/.config/nvim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +CocInstall coc-neosnippet coc-json coc-tsserver coc-html coc-css coc-yaml coc-highlight coc-emmet  +qall
