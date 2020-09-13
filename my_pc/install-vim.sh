# Install NERDTree
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q

# Install Line Indents
git clone https://github.com/Yggdroot/indentLine.git ~/.vim/pack/vendor/start/indentLine
vim -u NONE -c "helptags  ~/.vim/pack/vendor/start/indentLine/doc" -c q

# Install others plugin
install_fzf(){
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  sudo apt update && apt install ripgrep
  cat > ~/.bashrc <<'END'
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
END
}

install_vim_common(){
  cp ./vim.common ~/.vimrc
}

echo "[?] Do you want to install Fuzzy Finder fzf?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_fzf; break;;
    No ) break;;
  esac
done

echo "[?] Do you want to overwrite .vimrc configurations?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_vim_common; break;;
    No ) break;;
  esac
done
