#!/bin/bash

INITIAL_DIRECTORY=$(pwd)

sudo apt update && sudo apt upgrade -y
sudo apt install -y vim bashtop btop ncdu duf bat tilix nemo

######## TEMA DRACULA ########
# Instalação do tema dracula
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/dracula/vim.git dracula
echo -e 'packadd! dracula\nsyntax enable\ncolorscheme dracula' >> ~/.vim/vimrc
echo -e 'set number nowrap\n' >> ~/.vim/vimrc

# Instalação do dracula no Grub
cd /tmp
git clone https://github.com/dracula/grub.git
sudo mkdir /boot/grub/themes
sudo mv grub/dracula/ /boot/grub/themes/
echo 'GRUB_THEME="/boot/grub/themes/dracula/theme.txt"' >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Dracula no TILIX
cd INITIAL_DIRECTORY
mkdir /home/fernando/.config/tilix/
mkdir /home/fernando/.config/tilix/schemes
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

######## SETAR PROGRAMAS PADRÃO ########
sudo update-alternatives --config x-terminal-emulator
xdg-mime default nemo.desktop inode/directory application/xgnome-saved-search


sudo apt install -y gparted keepassxc alacarte gsmartcontrol calibre conky-all unzip snapd code stacer virtualbox github-desktop gnome-tweaks flameshot youtube-dl vlc steam lutris

####### PYENV DEPENDENCES ##########
sudo apt install -y libedit-dev libncurses5-dev zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev liblzma-dev libreadline-dev g++ make python-tk python3-tk tk-dev


####### FLATPAKS #########
flatpak install -y com.anydesk.Anydesk com.discordapp.Discord com.getpostman.Postman com.snes9x.Snes9x org.avidemux.Avidemux org.chromium.Chromium org.chromium.Chromium.Codecs org.duckstation.DuckStation org.gimp.GIMP org.inkscape.Inkscape org.libretro.RetroArch org.onlyoffice.desktopeditors org.qbittorrent.qBittorrent Dorg.signal.Signal rest.insomnia.Insomnia in.srev.guiscrcpy com.spotify.Client


######## BRAVE BROWSER ########
sudo apt install -y apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
cp /home/fernando/documentos/escritorio/Bookmarks/Bookmarks.json /home/fernando/.config/BraveSoftware/Brave-Browser/Default/Bookmarks


######## PYCHARM ########
# PYCHARM_RELEASE='pycharm-community'
PYCHARM_RELEASE='pycharm-professional'
sudo snap install $PYCHARM_RELEASE --classic


######## ASDF ########
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
source ~/.bashrc
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git   
asdf plugin-add java https://github.com/halcyon/asdf-java.git


######## SGBDs ########
sudo apt install -y postgresql postgresql-contrib libpq-dev
sudo apt install -y mysql-server mysql-client libmysqlclient-dev
