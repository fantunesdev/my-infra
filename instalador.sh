#!/bin/bash

INITIAL_DIRECTORY=$(pwd)

sudo apt update && upgrade
sudo apt install -i gparted tilix keepassxc alacarte grub-customizer gsmartcontrol calibre vim

### SETAR TILIX COMO TERMINAL PADRÃO ###
sudo update-alternatives --config x-terminal-emulator

### VIM ###
# Instalação do tema dracula
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
echo -e 'packadd! dracula\nsyntax enable\ncolorscheme dracula' >> ~/.vim/vimrc
# Contagem de linhas, não quebrar linha, indentação de 4 espaços e backspace de 4 espaços em linhas indentadas.
echo -e 'set number wrap title tabstop=4 softtabstop=4\n' >> ~/.vim/vimrc


### BRAVE BROWSER ###
sudo apt install -y apt-transport-https curl
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser

### CUSTOMIZAÇÕES DO TERMINAL ###
BASHRC_FILE="$HOME/.bashrc"

echo >> $BASHRC_FILE
echo 'export PS1='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]$ '\' >> $BASHRC_FILE
echo >> $BASHRC_FILE
echo 'echo export PSGIT='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]\n$ '\' >> $BASHRC_FILE
echo 'export PSTRAD='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]$ '\' >> $BASHRC_FILE
echo >> $BASHRC_FILE

### ASDF ###
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
echo '. $HOME/.asdf/asdf.sh' >> $BASHRC_FILE
echo '. $HOME/.asdf/completions/asdf.bash' >> $BASHRC_FILE
source ~/.bashrc
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
sudo apt update
sudo apt install python3 g++ make python3-pip

### PYTHON ###
asdf install python 3.10.8
asdf install python 3.10-dev
asdf install python latest
asdf install python 3.11-dev

### PYCHARM ###
# PYCHARM_RELEASE='pycharm-community'
PYCHARM_RELEASE='pycharm-professional'
sudo snap install $PYCHARM_RELEASE --classic

### VAULT ###
cd /tmp
curl https://releases.hashicorp.com/vault/1.4.0/vault_1.4.0_linux_amd64.zip -o vault.zip
unzip vault.zip
sudo mv vault /usr/local/bin
vault -autocomplete-install

### VAULTCTL ###
cd /tmp
git clone git@github.com:fantunesdev/vaultctl.git
cd vaultctl
sudo ./install.sh

### YouTube-DLG ###
curl http://ubuntu.mirrors.tds.net/ubuntu/pool/universe/t/twodict/python-twodict_1.2-1_all.deb -o /tmp/python-twodict_1.2-1_all.deb
curl http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.4-1~webupd8~disco0_all.deb -o /tmp/youtube-dlg_0.4-1~webupd8~disco0_all.deb
sudo apt install /tmp/python-twodict_1.2-1_all.deb /tmp/youtube-dlg_0.4-1~webupd8~disco0_all.deb
sudo apt install youtube-dl ffmpeg
