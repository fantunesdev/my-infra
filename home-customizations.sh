#!/bin/bash

######## TEMA DRACULA ########
# Instalação do tema dracula no vim
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
echo -e 'packadd! dracula\nsyntax enable\ncolorscheme dracula' >> ~/.vim/vimrc
echo -e 'set number nowrap\n' >> ~/.vim/vimrc


# Dracula no TILIX
cd INITIAL_DIRECTORY
mkdir -p /home/fernando/.config/tilix/schemes
cp files/tilix/Dracula.json ~/.config/tilix/schemes


######## CUSTOMIZAÇÕES DO TERMINAL ########
echo >> ~/.bashrc
echo 'export PS1='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]$ '\' >> ~/.bashrc
echo >> ~/.bashrc
echo 'export PSGIT='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]\n$ '\' >> ~/.bashrc
echo 'export PSTRAD='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]$ '\' >> ~/.bashrc
echo >> ~/.bashrc


# Configurar o PATH
echo 'export PATH=$PATH:/snap/bin:~/.pyenv/bin:~/.local/bin:~/git/bin' >> ~/.bashrc


# Conky
cp $INITIAL_DIRECTORY/files/conky ~/.config
cp $INITIAL_DIRECTORY/files/conky/conky-startup.sh.desktop ~/.config/autostart/
conky -c ~/.config/conky/Extra/Gothan/Gotham


# AutoStart do my-server
cp $INITIAL_DIRECTORY/files/my-server.desktop ~/.config/autostart/


######## ASDF ########
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
source ~/.bashrc
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git   
asdf plugin-add java https://github.com/halcyon/asdf-java.git
