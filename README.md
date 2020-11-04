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

    pip3 install --user --upgrade neovim
    cd && git clone https://github.com/tyao117/tyneovim ~/.tyneovim
    ln -sfv ~/.tyneovim ~/.config/nvim
    ln -sfv ~/.tyneovim/init.vim ~/.config/nvim
    ln -sfv ~/.tyneovim/coc-settings.json ~/.config/nvim
    ln -sfv ~/.tyneovim/plugins.vim ~/.config/nvim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +CocInstall coc-neosnippet coc-json coc-yaml coc-highlight coc-python +qall
