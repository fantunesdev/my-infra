#!/bin/bash

INITIAL_DIRECTORY=$(pwd)

sudo apt update && sudo apt upgrade -y
sudo apt install -y gparted tilix keepassxc alacarte grub-customizer gsmartcontrol calibre vim nemo conky-all unzip

flatpak install -y com.anydesk.Anydesk com.discordapp.Discord com.getpostman.Postman com.github.tchx84.Flatseal com.snes9x.Snes9x org.avidemux.Avidemux org.chromium.Chromium org.chromium.Chromium.Codecs org.duckstation.DuckStation org.flameshot.Flameshot org.gimp.GIMP org.inkscape.Inkscape org.libretro.RetroArch org.onlyoffice.desktopeditors org.qbittorrent.qBittorrent Dorg.signal.Signal rest.insomnia.Insomnia

######## SETAR PROGRAMAS PADRÃO ########
sudo update-alternatives --config x-terminal-emulator
xdg-mime default nemo.desktop inode/directory application/xgnome-saved-search

######## VIM ########
# Instalação do tema dracula
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
echo -e 'packadd! dracula\nsyntax enable\ncolorscheme dracula' >> ~/.vim/vimrc
# Contagem de linhas, não quebrar linha, indentação de 4 espaços e backspace de 4 espaços em linhas indentadas.
echo -e 'set number wrap title tabstop=4 softtabstop=4\n' >> ~/.vim/vimrc


######## BRAVE BROWSER ########
sudo apt install -y apt-transport-https curl
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser


######## CUSTOMIZAÇÕES DO TERMINAL ########
BASHRC_FILE="$HOME/.bashrc"

echo >> $BASHRC_FILE
echo 'export PS1='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]$ '\' >> $BASHRC_FILE
echo >> $BASHRC_FILE
echo 'echo export PSGIT='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]\n$ '\' >> $BASHRC_FILE
echo 'export PSTRAD='\''\e[1;35m\u@\h\e[m:\e[1;34m\w\e[m$(__git_ps1)\e[m\]$ '\' >> $BASHRC_FILE
echo >> $BASHRC_FILE


######## PYTHON ########

echo -e "
########################
##       PYTHON       ##
########################
"

# Instalação do PYENV
echo 'Instalando o pyenv...'
cd /tmp
export PYENV_GIT_TAG=v2.2.5
curl https://pyenv.run | bash
echo 'export PATH=$PATH:~/.pyenv/bin' >> ~/.bashrc
exec bash
sudo apt-get install -y python-tk python3-tk tk-dev
pyenv update

# Instalação do python

LATEST_PYTHON=$(pyenv latest 3)
IFS='.'
read -a LATEST_PYTHON_SPLITTED_STRING <<< $LATEST_PYTHON
unset IFS
HIGHER_VERSION=$(("${LATEST_PYTHON_SPLITTED_STRING[1]}"))
VERSION=$(($HIGHER_VERSION - 3))

while ((VERSION <= HIGHER_VERSION)); do
    pyenv install "3.$VERSION:latest"
    pyenv install "3.$VERSION-dev"
    let VERSION++
done

pyenv install anaconda3-2022:latest
pyenv global $LATEST_PYTHON

# Configurações
pip install --upgrade pip
pip install pipx
pipx install poetry
poetry config virtualenvs.in-project = true

######## PYTHON ########


######## PYCHARM ########
# PYCHARM_RELEASE='pycharm-community'
PYCHARM_RELEASE='pycharm-professional'
sudo snap install $PYCHARM_RELEASE --classic


######## ASDF ########
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
echo '. $HOME/.asdf/asdf.sh' >> $BASHRC_FILE
echo '. $HOME/.asdf/completions/asdf.bash' >> $BASHRC_FILE
source ~/.bashrc
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
sudo apt update
sudo apt install python3 g++ make python3-pip


######## VSCODE ########
sudo apt install -y code

######## SGBDs ########
sudo apt install -y postgresql postgresql-contrib
sudo apt install -y mysql-server mysql-client libmysqlclient-dev


######## VAULT ########

echo -e "
#######################
##       VAULT       ##
#######################
"
cd /tmp

echo 'Obtendo a última versão do vault...'
URL='https://releases.hashicorp.com/vault/'
VERSION=$(curl -s $URL | egrep -Eo "vault_[^/].[^/][^/].[^/]<" | cut -d"<" -f1 | head -n 1 | cut -d"_" -f2)

echo "Instalando o Vault $VERSION (latest)..."
DOWNLOAD_URL="https://releases.hashicorp.com/vault/$VERSION/vault_${VERSION}_linux_amd64.zip"
curl $DOWNLOAD_URL -o vault_$VERSION.zip
unzip vault_$VERSION.zip
sudo mv vault /usr/local/bin
vault -autocomplete-install
unset VERSION

echo "Instalando o VaultCtl..."
git clone git@github.com:fantunesdev/vaultctl.git
cd vaultctl
sudo ./install.sh

######## VAULT ########


######## YouTube-DLG ########
curl http://ubuntu.mirrors.tds.net/ubuntu/pool/universe/t/twodict/python-twodict_1.2-1_all.deb -o /tmp/python-twodict_1.2-1_all.deb
curl http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.4-1~webupd8~disco0_all.deb -o /tmp/youtube-dlg_0.4-1~webupd8~disco0_all.deb
sudo apt install /tmp/python-twodict_1.2-1_all.deb /tmp/youtube-dlg_0.4-1~webupd8~disco0_all.deb
sudo apt install youtube-dl ffmpeg
