git clone https://github.com/neovim/neovim.git
cd neovim/
git checkout stable
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=${HOME}/.local install
